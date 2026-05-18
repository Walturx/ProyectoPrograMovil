// lib/pages/profile/profile_page.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// CONTROLLER
import 'profile_controller.dart';

/// COMPONENTS
import '../../components/custom_bottom_nav.dart';

import '../../components/profile/profile_header.dart';

import '../../components/profile/profile_info_card.dart';

import '../../components/profile/profile_action_buttons.dart';

import '../../components/profile/edit_profile_modal.dart';

class ProfilePage
    extends StatelessWidget {

  ProfilePage({super.key});

  /// GETX CONTROLLER
  final ProfileController
      controller =
          Get.put(
    ProfileController(),
  );

  /// OPEN EDIT MODAL
  void openEditModal(
    BuildContext context,
  ) {

    showModalBottomSheet(

      context: context,

      isScrollControlled: true,

      backgroundColor:
          Colors.transparent,

      builder: (context) {

        return EditProfileModal(

          controller:
              controller,
        );
      },
    );
  }

  /// BUILD BODY
  Widget _buildBody(
    BuildContext context,
  ) {

    return SafeArea(

      child:
          SingleChildScrollView(

        padding:
            const EdgeInsets.all(
                20),

        child: Column(
          children: [

            const SizedBox(
                height: 10),

            /// TITLE
            const Text(

              "Mi Perfil",

              style: TextStyle(
                fontSize: 30,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 30),

            /// PROFILE HEADER
            ProfileHeader(

              controller:
                  controller,

              onEdit: () {

                openEditModal(
                    context);
              },
            ),

            const SizedBox(
                height: 28),

            /// PROFILE INFO
            ProfileInfoCard(

              controller:
                  controller,
            ),

            const SizedBox(
                height: 24),

            /// ACTION BUTTONS
            ProfileActionButtons(

              onEdit: () {

                openEditModal(
                    context);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return Obx(() {

      /// LOADING
      if (controller
          .isLoading.value) {

        return const Scaffold(

          body: Center(

            child:
                CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(

        /// BOTTOM NAVIGATION
        bottomNavigationBar:
            const CustomBottomNav(

          currentIndex: 1,
        ),

        /// BODY
        body:
            _buildBody(
          context,
        ),
      );
    });
  }
}