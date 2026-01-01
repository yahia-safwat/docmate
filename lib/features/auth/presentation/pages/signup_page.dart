import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    // final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Signup page is coming soon!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Mocking a successful signup for now
                // context.read<AuthBloc>().add(AuthUserChanged(...));
              },
              child: const Text('Simulate Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
