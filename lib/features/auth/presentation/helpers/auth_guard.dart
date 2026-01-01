import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../widgets/auth_bottom_sheet.dart';

extension AuthGuard on BuildContext {
  void requireAuth(VoidCallback onAuthenticated) {
    final authState = read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      onAuthenticated();
    } else {
      AuthBottomSheet.show(this);
    }
  }
}
