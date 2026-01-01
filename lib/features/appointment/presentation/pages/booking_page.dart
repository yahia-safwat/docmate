import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection_container.dart';
import '../../../auth/presentation/helpers/auth_guard.dart';
import '../blocs/booking/booking_bloc.dart';
import '../blocs/booking/booking_event.dart';
import '../blocs/booking/booking_state.dart';

class BookingPage extends StatelessWidget {
  final String doctorId;

  const BookingPage({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<BookingBloc>()..add(BookingDateChanged(DateTime.now())),
      child: BookingView(doctorId: doctorId),
    );
  }
}

class BookingView extends StatelessWidget {
  final String doctorId;

  const BookingView({super.key, required this.doctorId});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Book Appointment')),
      body: BlocConsumer<BookingBloc, BookingState>(
        listener: (context, state) {
          if (state.status == BookingStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Appointment Booked Successfully!')),
            );
            context.pop();
          } else if (state.status == BookingStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Booking failed')),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _SectionHeader(title: 'Select Date', textTheme: textTheme),
                const SizedBox(height: 16),
                Card(
                  elevation: 0,
                  color: colorScheme.surfaceContainerLow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                    onDateChanged: (date) {
                      context.read<BookingBloc>().add(BookingDateChanged(date));
                    },
                  ),
                ),
                const SizedBox(height: 32),
                _SectionHeader(title: 'Available Slots', textTheme: textTheme),
                const SizedBox(height: 16),
                if (state.status == BookingStatus.loading)
                  const Center(child: CircularProgressIndicator())
                else if (state.availableSlots.isEmpty)
                  const Center(child: Text('No slots available for this date'))
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: state.availableSlots.length,
                    itemBuilder: (context, index) {
                      final slot = state.availableSlots[index];
                      final isSelected = state.selectedSlot == slot;
                      return _SlotTile(
                        slot: slot,
                        isSelected: isSelected,
                        onTap: () {
                          context.read<BookingBloc>().add(
                            BookingSlotSelected(slot),
                          );
                        },
                      );
                    },
                  ),
                const SizedBox(height: 48),
                FilledButton(
                  onPressed:
                      state.selectedSlot == null ||
                          state.status == BookingStatus.submitting
                      ? null
                      : () {
                          context.requireAuth(() {
                            context.read<BookingBloc>().add(
                              BookingSubmitted(doctorId: doctorId),
                            );
                          });
                        },
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: state.status == BookingStatus.submitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Confirm Booking'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final TextTheme textTheme;

  const _SectionHeader({required this.title, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _SlotTile extends StatelessWidget {
  final TimeOfDay slot;
  final bool isSelected;
  final VoidCallback onTap;

  const _SlotTile({
    required this.slot,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outlineVariant,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          slot.format(context),
          style: textTheme.bodyMedium?.copyWith(
            color: isSelected ? Colors.white : colorScheme.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.bold : null,
          ),
        ),
      ),
    );
  }
}
