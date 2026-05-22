// lib/components/profile/profile_info_card.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart' show Obx;

/// CONTROLLER
import '../../pages/profile/profile_controller.dart';

/// COMPONENTS
import '../info_tile.dart';

class ProfileInfoCard
    extends StatelessWidget {

  final ProfileController
      controller;

  const ProfileInfoCard({

    super.key,

    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return Obx(() => Card(

      child: Column(
        children: [

          InfoTile(

            icon: Icons.person,

            title: "Nombre",

            value:
                "${controller.user.value?.name ?? ""} ${controller.user.value?.lastname ?? ""}",
          ),

          const Divider(),

          InfoTile(

            icon: Icons.email,

            title: "Correo",

            value:
                controller
                        .user
                        .value
                        ?.email ??
                    "",
          ),

          const Divider(),

          InfoTile(

            icon: Icons.phone,

            title:
                "Teléfono",

            value:
                controller
                        .user
                        .value
                        ?.phone ??
                    "",
          ),

          const Divider(),

          InfoTile(

            icon: Icons.badge,

            title:
                "Documento",

            value:
                controller
                        .user
                        .value
                        ?.documentNumber ??
                    "",
          ),

          const Divider(),

          InfoTile(

            icon: Icons.flag,

            title:
                "Nacionalidad",

            value:
                controller
                        .user
                        .value
                        ?.nationality ??
                    "",
          ),
        ],
      ),
    ));
  }
}