// lib/components/profile/profile_action_buttons.dart

import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class ProfileActionButtons extends StatelessWidget {
  final VoidCallback onEdit;

  const ProfileActionButtons({super.key, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 18),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );

    return Column(
      children: [
        /// EDIT BUTTON
        SizedBox(
          width: double.infinity,

          child: ElevatedButton.icon(
            onPressed: onEdit,

            icon: const Icon(Icons.edit),

            label: const Text("Editar Perfil"),

            style: buttonStyle,
          ),
        ),

        const SizedBox(height: 16),

        /// HISTORY BUTTON
        SizedBox(
          width: double.infinity,

          child: ElevatedButton.icon(
            onPressed: () {
              context.push('/history');
            },

            icon: const Icon(Icons.history),

            label: const Text("Ver historial"),

            style: buttonStyle,
          ),
        ),
      ],
    );
  }
}
