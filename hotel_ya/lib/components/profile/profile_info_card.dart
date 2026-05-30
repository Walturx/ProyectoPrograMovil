// lib/components/profile/profile_info_card.dart

import 'package:flutter/material.dart';

/// MODEL
import '../../models/user_model.dart';

/// COMPONENTS
import '../info_tile.dart';

class ProfileInfoCard extends StatelessWidget {
  final UserModel user;

  const ProfileInfoCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),

        child: Column(
          children: [
            InfoTile(
              icon: Icons.person,

              title: "Nombre",

              value: "${user.name} ${user.lastname}",
            ),

            const Divider(),

            InfoTile(icon: Icons.email, title: "Correo", value: user.email),

            const Divider(),

            InfoTile(icon: Icons.phone, title: "Teléfono", value: user.phone),

            const Divider(),

            InfoTile(
              icon: Icons.badge,

              title: "Documento",

              value: user.documentNumber,
            ),

            const Divider(),

            InfoTile(
              icon: Icons.flag,

              title: "Nacionalidad",

              value: user.nationality,
            ),
          ],
        ),
      ),
    );
  }
}
