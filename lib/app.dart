import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection_container.dart' as di;
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/home/presentation/blocs/home/home_bloc.dart';
import 'features/auth/presentation/blocs/auth/auth_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // trigger the initial events
    final homeBloc = di.sl<HomeBloc>()..add(const HomeEvent.loadHome());
    final authBloc = di.sl<AuthBloc>()..add(AuthCheckRequested());

    return MultiBlocProvider(
      providers: [
        // Home Bloc
        BlocProvider<HomeBloc>(create: (_) => homeBloc),
        // Auth Bloc
        BlocProvider<AuthBloc>(create: (_) => authBloc),
      ],
      child: const AppView(),
    );
  }
}

// AppView is the root widget of the application.
class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'DocMate App',
      routerConfig: AppRouter.router,
      theme: const AppTheme().themeData,
    );
  }
}
