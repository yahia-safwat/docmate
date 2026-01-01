import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/di/injection_container.dart';
import '../blocs/my_appointments/my_appointments_bloc.dart';
import '../blocs/my_appointments/my_appointments_event.dart';
import '../blocs/my_appointments/my_appointments_state.dart';
import '../../domain/entities/appointment.dart';

class MyAppointmentsPage extends StatefulWidget {
  const MyAppointmentsPage({super.key});

  @override
  State<MyAppointmentsPage> createState() => _MyAppointmentsPageState();
}

class _MyAppointmentsPageState extends State<MyAppointmentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MyAppointmentsBloc>()..add(FetchMyAppointments()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Appointments'),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Upcoming'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            AppointmentsListView(isUpcoming: true),
            AppointmentsListView(isUpcoming: false),
          ],
        ),
      ),
    );
  }
}

class AppointmentsListView extends StatelessWidget {
  final bool isUpcoming;

  const AppointmentsListView({super.key, required this.isUpcoming});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAppointmentsBloc, MyAppointmentsState>(
      builder: (context, state) {
        if (state is MyAppointmentsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MyAppointmentsLoaded) {
          final now = DateTime.now();
          final filtered = state.appointments.where((appointment) {
            final appointmentDateTime = DateTime(
              appointment.date.year,
              appointment.date.month,
              appointment.date.day,
              appointment.time.hour,
              appointment.time.minute,
            );
            if (isUpcoming) {
              return appointmentDateTime.isAfter(now);
            } else {
              return appointmentDateTime.isBefore(now);
            }
          }).toList();

          if (filtered.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isUpcoming ? Icons.calendar_today_outlined : Icons.history,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isUpcoming
                        ? 'No upcoming appointments'
                        : 'No appointment history',
                    style: const TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: filtered.isEmpty ? 0 : filtered.length,
            itemBuilder: (context, index) {
              final appointment = filtered[index];
              return AppointmentCard(appointment: appointment);
            },
          );
        } else if (state is MyAppointmentsError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('EEE, MMM d, yyyy');
    // final timeFormat = DateFormat('hh:mm a');

    // Fallback if formatting fails (TimeOfDay doesn't have a direct DateTime conversion)
    final timeStr = appointment.time.format(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: colorScheme.primaryContainer,
                  child: Icon(Icons.person, color: colorScheme.primary),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. John Doe', // Mock doctor name
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        'Cardiologist', // Mock category
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                if (appointment.status != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      appointment.status!.name,
                      style: TextStyle(
                        color: colorScheme.onSecondaryContainer,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(dateFormat.format(appointment.date)),
                const SizedBox(width: 16),
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(timeStr),
              ],
            ),
            if (appointment.reason != null &&
                appointment.reason!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Reason: ${appointment.reason}',
                style: const TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<MyAppointmentsBloc>().add(
                        CancelAppointment(id: appointment.id),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: colorScheme.error,
                      side: BorderSide(color: colorScheme.error),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      // Navigate to details or reschedule
                    },
                    child: const Text('Details'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
