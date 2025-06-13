import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:portal_flow/features/auth/auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc bloc) => bloc.state.user);

    return Scaffold(
      extendBody: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (user.profileImage != null)
            Container(
              width: 125,
              height: 125,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: ClipOval(
                child: Image.memory(
                  user.profileImage!,
                  fit: BoxFit.cover,
                ),
              ),
            )
          else
            Container(
              width: 125,
              height: 125,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.15),
                border: Border.all(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.primary,
                size: 76,
              ),
            ),

          const SizedBox(
            height: 20,
          ),

          Text(
            user.name,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(
                context,
              ).colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(
            height: 40,
          ),

          // Botão de logout
          ElevatedButton.icon(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogoutPressed());
            },
            icon: Icon(
              LucideIcons.logOut,
              color: Theme.of(
                context,
              ).colorScheme.onPrimary,
            ),
            label: const Text('Sair', style: TextStyle(fontSize: 18),),
          ),
        ],
      ),
    );
  }
}
