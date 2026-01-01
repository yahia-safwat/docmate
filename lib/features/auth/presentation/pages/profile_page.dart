import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/app_routes.dart';
import '../blocs/auth/auth_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(AppRoutes.settings),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final bool isAuthenticated = state is AuthAuthenticated;
          final user = isAuthenticated ? state.user : null;

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isAuthenticated)
                  _buildAuthenticatedHeader(
                    context,
                    user!,
                    textTheme,
                    colorScheme,
                  )
                else
                  _buildGuestHeader(context, textTheme, colorScheme),

                const SizedBox(height: 32),

                _SectionHeader(title: 'Account Settings', textTheme: textTheme),
                _ProfileTile(
                  icon: Icons.person_outline,
                  title: 'Personal Information',
                  onTap: () {},
                  enabled: isAuthenticated,
                ),
                _ProfileTile(
                  icon: Icons.calendar_today_outlined,
                  title: 'My Appointments',
                  onTap: () {},
                  enabled: isAuthenticated,
                ),
                _ProfileTile(
                  icon: Icons.favorite_border,
                  title: 'Favorites',
                  onTap: () {},
                  enabled: isAuthenticated,
                ),

                const SizedBox(height: 24),
                _SectionHeader(title: 'App Settings', textTheme: textTheme),
                _ProfileTile(
                  icon: Icons.settings_outlined,
                  title: 'General Settings',
                  onTap: () => context.push(AppRoutes.settings),
                ),
                _ProfileTile(
                  icon: Icons.notifications_none_outlined,
                  title: 'Notifications',
                  onTap: () {},
                ),

                const SizedBox(height: 24),
                _SectionHeader(title: 'Support & Legal', textTheme: textTheme),
                _ProfileTile(
                  icon: Icons.help_outline,
                  title: 'Help Center',
                  onTap: () {},
                ),
                _ProfileTile(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Privacy Policy',
                  onTap: () {},
                ),
                _ProfileTile(
                  icon: Icons.description_outlined,
                  title: 'Terms & Conditions',
                  onTap: () {},
                ),

                if (isAuthenticated) ...[
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogoutRequested());
                        context.go(AppRoutes.home);
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Logout'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.error,
                        side: BorderSide(color: colorScheme.error),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAuthenticatedHeader(
    BuildContext context,
    dynamic user,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: colorScheme.primaryContainer,
            child: Icon(Icons.person, size: 40, color: colorScheme.primary),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  user.email,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGuestHeader(
    BuildContext context,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Text(
              'Join DocMate',
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sign in to book appointments and track your health journey.',
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.primary.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () => context.push(AppRoutes.login),
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Login / Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final TextTheme textTheme;

  const _SectionHeader({required this.title, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 8),
      child: Text(
        title.toUpperCase(),
        style: textTheme.labelLarge?.copyWith(
          letterSpacing: 1.2,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool enabled;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: enabled
              ? colorScheme.surface
              : colorScheme.onSurface.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: 20,
          color: enabled
              ? colorScheme.onSurface
              : colorScheme.onSurface.withValues(alpha: 0.3),
        ),
      ),
      title: Text(
        title,
        style: textTheme.bodyLarge?.copyWith(
          color: enabled
              ? colorScheme.onSurface
              : colorScheme.onSurface.withValues(alpha: 0.3),
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        size: 20,
        color: colorScheme.onSurface.withValues(alpha: enabled ? 0.3 : 0.1),
      ),
      onTap: enabled ? onTap : null,
    );
  }
}
