import 'package:flutter/material.dart';
import '../../features/doctor/presentation/pages/doctor_details/doctor_details_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/auth/presentation/pages/profile_page.dart';
import '../../features/auth/presentation/pages/settings_page.dart';
import '../../features/auth/presentation/blocs/auth/auth_bloc.dart';
import 'app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        path: AppRoutes.login,
        name: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        name: AppRoutes.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: AppRoutes.doctorDetails,
        name: AppRoutes.doctorDetails,
        builder: (context, state) {
          final doctorId = state.pathParameters['doctorId']!;
          return DoctorDetailsPage(doctorId: doctorId);
        },
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: AppRoutes.profile,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: AppRoutes.settings,
        builder: (context, state) => const SettingsPage(),
      ),
    ],
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isLoggingIn = state.matchedLocation == AppRoutes.login;

      // We only redirect away from login if already authenticated
      if (authState is AuthAuthenticated && isLoggingIn) {
        return AppRoutes.home;
      }

      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('No route found for ${state.error}')),
    ),
  );
}
