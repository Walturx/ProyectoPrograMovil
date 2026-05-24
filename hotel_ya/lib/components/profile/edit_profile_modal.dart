import 'package:flutter/material.dart';
import 'package:get/get.dart' show Obx;
import '../../pages/profile/profile_controller.dart';

class EditProfileModal extends StatefulWidget {
  final ProfileController controller;

  const EditProfileModal({super.key, required this.controller});

  @override
  State<EditProfileModal> createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  @override
  void initState() {
    super.initState();
    // Resetea los campos con los valores ACTUALES guardados cada vez que abre
    final user = widget.controller.user.value;
    if (user != null) {
      widget.controller.nameController.text = user.name;
      widget.controller.lastnameController.text = user.lastname;
      widget.controller.phoneController.text = user.phone;
      widget.controller.nationalityController.text = user.nationality;
      widget.controller.documentController.text = user.documentNumber;
      widget.controller.avatarController.text = user.avatarUrl;
      widget.controller.previewAvatar.value = user.avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// TITLE
              const Text(
                "Editar Perfil",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 24),

              /// PREVIEW AVATAR
              Center(
                child: Obx(() {
                  return Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage:
                            widget.controller.previewAvatar.value.isNotEmpty
                            ? NetworkImage(
                                widget.controller.previewAvatar.value,
                              )
                            : null,
                        child: widget.controller.previewAvatar.value.isEmpty
                            ? const Icon(Icons.person, size: 50)
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4AF37),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),

              const SizedBox(height: 24),

              _buildField(
                controller: widget.controller.avatarController,
                label: "Avatar URL",
                onChanged: widget.controller.updateAvatarPreview,
              ),
              _buildField(
                controller: widget.controller.nameController,
                label: "Nombre",
              ),
              _buildField(
                controller: widget.controller.lastnameController,
                label: "Apellido",
              ),
              _buildField(
                controller: widget.controller.phoneController,
                label: "Teléfono",
                keyboardType: TextInputType.phone,
              ),
              _buildField(
                controller: widget.controller.documentController,
                label: "Documento",
              ),
              _buildField(
                controller: widget.controller.nationalityController,
                label: "Nacionalidad",
              ),

              const SizedBox(height: 30),

              /// SAVE BUTTON
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: widget.controller.user.value == null
                      ? null
                      : () {
                          widget.controller.updateProfile();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Perfil actualizado correctamente"),
                            ),
                          );
                          Navigator.pop(context);
                        },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Guardar Cambios",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
