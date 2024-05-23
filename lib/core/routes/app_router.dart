import 'package:flutter/material.dart';

import '../../features/doctor/presentation/pages/doctor_details/doctor_details_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'app_routes.dart';

import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.doctorDetails,
        name: AppRoutes.doctorDetails,
        builder: (context, state) {
          final doctorId = state.pathParameters['doctorId']!;
          return DoctorDetailsPage(doctorId: doctorId);
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('No route found for ${state.error}'),
      ),
    ),
  );
}
