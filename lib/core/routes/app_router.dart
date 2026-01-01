import 'package:flutter/material.dart';
import '../../features/doctor/presentation/pages/doctor_details/doctor_details_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/signup_page.dart';
import '../../features/auth/presentation/pages/profile_page.dart';
import '../../features/auth/presentation/pages/settings_page.dart';
import '../../features/appointment/presentation/pages/booking_page.dart';
import '../../features/appointment/presentation/pages/my_appointments_page.dart';
import '../../features/auth/presentation/blocs/auth/auth_bloc.dart';
import '../../features/doctor/presentation/pages/global_search_page.dart';
import '../../features/chat/presentation/pages/chat_list_page.dart';
import '../../features/chat/presentation/pages/chat_detail_room.dart';
import '../../features/doctor/domain/entities/doctor.dart';
import 'app_routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../common/widgets/scaffolds/main_scaffold.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.home,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScaffold(navigationShell: navigationShell);
        },
        branches: [
          // Branch for Home/Discover
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                name: AppRoutes.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          // Branch for Explore
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.explore,
                builder: (context, state) => const GlobalSearchPage(),
              ),
            ],
          ),
          // Branch for Booking Tab (My Appointments)
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.myAppointments,
                builder: (context, state) => const MyAppointmentsPage(),
              ),
            ],
          ),
          // Branch for Chat
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.chat,
                builder: (context, state) => const ChatListPage(),
                routes: [
                  GoRoute(
                    path: AppRoutes.chatDetail,
                    name: AppRoutes.chatDetail,
                    builder: (context, state) {
                      final chatId = state.pathParameters['chatId']!;
                      final participant = state.extra as Doctor;
                      return ChatDetailRoom(
                        chatId: chatId,
                        participant: participant,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          // Branch for Profile
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                name: AppRoutes.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
      // Auth Routes (Top level to hide bottom bar)
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        name: AppRoutes.signup,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SignupPage(),
      ),
      // Details & Sub-pages
      GoRoute(
        path: AppRoutes.doctorDetails,
        name: AppRoutes.doctorDetails,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final doctorId = state.pathParameters['doctorId']!;
          return DoctorDetailsPage(doctorId: doctorId);
        },
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: AppRoutes.settings,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.booking,
        name: AppRoutes.booking,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final doctorId = state.pathParameters['doctorId']!;
          return BookingPage(doctorId: doctorId);
        },
      ),
    ],
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isLoggingIn = state.matchedLocation == AppRoutes.login;

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
