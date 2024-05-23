import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/widgets/cards/doctor_card.dart';
import '../blocs/doctor_details/doctor_details_bloc.dart';
import 'doctor_working_hours.dart';

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
                Divider(height: 32.0, color: colorScheme.surfaceVariant),
                DoctorWorkingHoursView(workingHours: doctor.workingHours),
              ],
            ),
          ),
          error: (msg) => const Center(child: Text('Something went wrong')),
        );
      },
    );
  }
}
