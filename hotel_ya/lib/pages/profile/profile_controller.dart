// lib/pages/profile/profile_controller.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// MODEL
import '../../models/user_model.dart';

/// SERVICE
import '../../services/profile_service.dart';

class ProfileController extends GetxController {
  /// PROFILE SERVICE
  final ProfileService profileService = ProfileService();

  /// USER DATA
  Rx<UserModel?> user = Rx<UserModel?>(null);

  /// LOADING
  RxBool isLoading = true.obs;

  /// PREVIEW AVATAR
  RxString previewAvatar = "".obs;

  /// TEXT CONTROLLERS
  final TextEditingController nameController = TextEditingController();

  final TextEditingController lastnameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController nationalityController = TextEditingController();

  final TextEditingController documentController = TextEditingController();

  final TextEditingController avatarController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    /// LOAD USER
    loadUser();
  }

  /// LOAD USER
  Future<void> loadUser() async {
    try {
      final response = await profileService.fetchUser();

      if (response.success && response.hasData) {
        user.value = response.data;

        /// INITIAL VALUES
        nameController.text = user.value!.name;
        lastnameController.text = user.value!.lastname;
        phoneController.text = user.value!.phone;
        nationalityController.text = user.value!.nationality;
        documentController.text = user.value!.documentNumber;
        avatarController.text = user.value!.avatarUrl;

        /// PREVIEW AVATAR
        previewAvatar.value = user.value!.avatarUrl;
      } else {
        print("ERROR PROFILE CONTROLLER:");
        print(response.error);
      }
    } catch (e) {
      print("LOAD USER ERROR:");
      print(e);
    } finally {
      /// FINISH LOADING
      isLoading.value = false;
    }
  }

  /// UPDATE AVATAR PREVIEW
  void updateAvatarPreview(String value) {
    previewAvatar.value = value;
  }

  /// UPDATE PROFILE
  void updateProfile() {
    if (user.value == null) return;

    final updated = user.value!.copyWith(
      name: nameController.text,
      lastname: lastnameController.text,
      phone: phoneController.text,
      nationality: nationalityController.text,
      documentNumber: documentController.text,
      avatarUrl: avatarController.text,
    );

    user.value = updated;
    profileService.updateUser(updated); // persiste en cache de sesión
  }

  @override
  void onClose() {
    /// DISPOSE CONTROLLERS
    nameController.dispose();
    lastnameController.dispose();
    phoneController.dispose();
    nationalityController.dispose();
    documentController.dispose();
    avatarController.dispose();
    super.onClose();
  }
}
