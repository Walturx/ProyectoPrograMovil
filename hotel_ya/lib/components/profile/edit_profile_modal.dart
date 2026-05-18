// lib/components/profile/edit_profile_modal.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// CONTROLLER
import '../../pages/profile/profile_controller.dart';

class EditProfileModal
    extends StatelessWidget {

  final ProfileController
      controller;

  const EditProfileModal({

    super.key,

    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: EdgeInsets.only(

        bottom:
            MediaQuery.of(context)
                .viewInsets
                .bottom,
      ),

      child: Container(

        padding:
            const EdgeInsets.all(
                24),

        decoration:
            const BoxDecoration(

          color: Colors.white,

          borderRadius:
              BorderRadius.vertical(
            top:
                Radius.circular(
                    30),
          ),
        ),

        child:
            SingleChildScrollView(

          child: Column(

            mainAxisSize:
                MainAxisSize.min,

            crossAxisAlignment:
                CrossAxisAlignment
                    .start,

            children: [

              /// TITLE
              const Text(

                "Editar Perfil",

                style: TextStyle(
                  fontSize: 28,
                  fontWeight:
                      FontWeight
                          .bold,
                ),
              ),

              const SizedBox(
                  height: 24),

              /// PREVIEW AVATAR
              Center(

                child: Obx(() {

                  return Stack(

                    children: [

                      CircleAvatar(

                        radius: 55,

                        backgroundColor:
                            Colors.grey
                                .shade200,

                        backgroundImage:
                            controller
                                    .previewAvatar
                                    .value
                                    .isNotEmpty
                                ? NetworkImage(

                                    controller
                                        .previewAvatar
                                        .value,
                                  )
                                : null,

                        child: controller
                                .previewAvatar
                                .value
                                .isEmpty
                            ? const Icon(
                                Icons.person,

                                size: 50,
                              )
                            : null,
                      ),

                      Positioned(

                        bottom: 0,
                        right: 0,

                        child:
                            Container(

                          padding:
                              const EdgeInsets
                                  .all(
                                      8),

                          decoration:
                              BoxDecoration(

                            color:
                                Colors.blue,

                            shape:
                                BoxShape
                                    .circle,

                            border:
                                Border.all(
                              color: Colors
                                  .white,

                              width:
                                  3,
                            ),
                          ),

                          child:
                              const Icon(

                            Icons
                                .camera_alt,

                            color: Colors
                                .white,

                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),

              const SizedBox(
                  height: 24),

              /// AVATAR URL
              TextField(

                controller:
                    controller
                        .avatarController,

                onChanged:
                    controller
                        .updateAvatarPreview,

                decoration:
                    const InputDecoration(

                  labelText:
                      "Avatar URL",
                ),
              ),

              const SizedBox(
                  height: 18),

              /// NAME
              TextField(

                controller:
                    controller
                        .nameController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Nombre",
                ),
              ),

              const SizedBox(
                  height: 18),

              /// LASTNAME
              TextField(

                controller:
                    controller
                        .lastnameController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Apellido",
                ),
              ),

              const SizedBox(
                  height: 18),

              /// PHONE
              TextField(

                controller:
                    controller
                        .phoneController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Teléfono",
                ),
              ),

              const SizedBox(
                  height: 18),

              /// DOCUMENT
              TextField(

                controller:
                    controller
                        .documentController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Documento",
                ),
              ),

              const SizedBox(
                  height: 18),

              /// NATIONALITY
              TextField(

                controller:
                    controller
                        .nationalityController,

                decoration:
                    const InputDecoration(
                  labelText:
                      "Nacionalidad",
                ),
              ),

              const SizedBox(
                  height: 30),

              /// SAVE BUTTON
              SizedBox(

                width:
                    double.infinity,

                child:
                    ElevatedButton(

                  onPressed: () {

                    /// UPDATE PROFILE
                    controller
                        .updateProfile();

                    /// CLOSE MODAL
                    Navigator.pop(
                        context);

                    /// SUCCESS MESSAGE
                    Get.snackbar(

                      "Éxito",

                      "Perfil actualizado correctamente",

                      snackPosition:
                          SnackPosition
                              .BOTTOM,
                    );
                  },

                  style:
                      ElevatedButton
                          .styleFrom(

                    padding:
                        const EdgeInsets
                            .symmetric(
                      vertical:
                          18,
                    ),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius
                              .circular(
                                  20),
                    ),
                  ),

                  child:
                      const Text(

                    "Guardar Cambios",

                    style: TextStyle(
                      fontSize: 16,
                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                  height: 20),
            ],
          ),
        ),
      ),
    );
  }
}