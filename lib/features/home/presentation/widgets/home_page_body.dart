import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/home/home_bloc.dart';
import 'doctor_categories.dart';
import 'my_schedule.dart';
import 'nearby_doctors.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          loaded: (doctorCategories, nearbyDoctors, myAppointments) =>
              SingleChildScrollView(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                DoctorCategories(doctorCategories: doctorCategories),
                const SizedBox(height: 24.0),
                MySchedule(myAppointments: myAppointments),
                const SizedBox(height: 24.0),
                NearbyDoctors(nearbyDoctors: nearbyDoctors),
              ],
            ),
          ),
          error: (error) => Center(child: Text(error)),
        );
      },
    );
  }
}
