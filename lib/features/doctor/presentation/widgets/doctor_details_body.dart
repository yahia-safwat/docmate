import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/cards/doctor_card.dart';
import '../blocs/doctor_details/doctor_details_bloc.dart';
import 'doctor_working_hours.dart';
import '../../../auth/presentation/helpers/auth_guard.dart';

class DoctorDetailsBody extends StatelessWidget {
  const DoctorDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<DoctorDetailsBloc, DoctorDetailsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (doctor) => SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DoctorCard(doctor: doctor),
                Divider(
                  height: 32.0,
                  color: colorScheme.surfaceContainerHighest,
                ),
                DoctorWorkingHoursView(workingHours: doctor.workingHours),
                const SizedBox(height: 16.0),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () {
                      context.requireAuth(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Booking flow coming soon!'),
                          ),
                        );
                      });
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                    ),
                    child: const Text('Book Now'),
                  ),
                ),
                const SizedBox(height: 8.0),
              ],
            ),
          ),
          error: (msg) => const Center(child: Text('Something went wrong')),
        );
      },
    );
  }
}
