// lib/pages/profile/profile_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// CONTROLLER
import 'profile_controller.dart';

/// COMPONENTS
import '../../components/profile/profile_header.dart';
import '../../components/profile/profile_info_card.dart';
import '../../components/profile/profile_action_buttons.dart';
import '../../components/profile/edit_profile_modal.dart';

/// NAVBAR
import '../../components/custom_bottom_nav.dart';



class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  /// CONTROLLER
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      /// LOADING
      if (controller.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      /// USER
      final user = controller.user.value;

      /// NULL USER
      if (user == null) {
        return const Scaffold(body: Center(child: Text("No user found")));
      }

      return Scaffold(
        backgroundColor: const Color(0xFFF8F6F1),

        bottomNavigationBar: const CustomBottomNav(currentIndex: 1),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const SizedBox(height: 10),

                  /// HEADER
                  ProfileHeader(
                    user: user,

                    onEdit: () {
                      showModalBottomSheet(
                        context: context,

                        isScrollControlled: true,

                        backgroundColor: Colors.transparent,

                        builder: (_) {
                          return EditProfileModal(controller: controller);
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  /// INFO CARD
                  ProfileInfoCard(user: user),

                  const SizedBox(height: 24),

                  /// ACTION BUTTONS
                  ProfileActionButtons(
                    onEdit: () {
                      showModalBottomSheet(
                        context: context,

                        isScrollControlled: true,

                        backgroundColor: Colors.transparent,

                        builder: (_) {
                          return EditProfileModal(controller: controller);
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
