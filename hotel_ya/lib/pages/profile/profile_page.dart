
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/custom_bottom_nav.dart';
import '../../widgets/info_tile.dart';
import '../history/history_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() =>
      _ProfilePageState();
}

class _ProfilePageState
    extends State<ProfilePage> {

  Map<String, dynamic>? user;

  bool isLoading = true;

  /// CONTROLLERS
  final TextEditingController
      nameController =
          TextEditingController();

  final TextEditingController
      lastnameController =
          TextEditingController();

  final TextEditingController
      phoneController =
          TextEditingController();

  final TextEditingController
      nationalityController =
          TextEditingController();

  final TextEditingController
      documentController =
          TextEditingController();

  final TextEditingController
      avatarController =
          TextEditingController();

  /// PREVIEW AVATAR
  String previewAvatar = "";

  @override
  void initState() {
    super.initState();

    loadUser();
  }

  Future<void> loadUser() async {

    try {

      final String response =
          await rootBundle.loadString(
        'assets/json/users.json',
      );

      final data =
          json.decode(response);

      setState(() {

        user = data[0];

        /// INITIAL VALUES
        nameController.text =
            user!["name"];

        lastnameController.text =
            user!["lastname"];

        phoneController.text =
            user!["phone"];

        nationalityController.text =
            user!["nationality"];

        documentController.text =
            user!["document_number"];

        avatarController.text =
            user!["avatar_url"];

        previewAvatar =
            user!["avatar_url"];

        isLoading = false;
      });

    } catch (e) {

      print("ERROR JSON:");
      print(e);
    }
  }

  void openEditModal() {

    showModalBottomSheet(

      context: context,

      isScrollControlled: true,

      backgroundColor:
          Colors.transparent,

      builder: (context) {

        return StatefulBuilder(

          builder:
              (context, modalSetState) {

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

                        child: Stack(

                          children: [

                            CircleAvatar(

                              radius: 55,

                              backgroundColor:
                                  Colors
                                      .grey
                                      .shade200,

                              backgroundImage:
                                  previewAvatar
                                          .isNotEmpty
                                      ? NetworkImage(
                                          previewAvatar,
                                        )
                                      : null,

                              child:
                                  previewAvatar
                                          .isEmpty
                                      ? const Icon(
                                          Icons
                                              .person,

                                          size:
                                              50,
                                        )
                                      : null,
                            ),

                            Positioned(

                              bottom: 0,
                              right: 0,

                              child: Container(

                                padding:
                                    const EdgeInsets
                                        .all(
                                            8),

                                decoration:
                                    BoxDecoration(

                                  color: Colors
                                      .blue,

                                  shape: BoxShape
                                      .circle,

                                  border:
                                      Border
                                          .all(
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
                        ),
                      ),

                      const SizedBox(
                          height: 24),

                      /// AVATAR URL
                      TextField(

                        controller:
                            avatarController,

                        onChanged:
                            (value) {

                          modalSetState(() {

                            previewAvatar =
                                value;
                          });

                          setState(() {

                            previewAvatar =
                                value;
                          });
                        },

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
                            nameController,

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
                            lastnameController,

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
                            phoneController,

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
                            documentController,

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
                            nationalityController,

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

                            setState(() {

                              user!["name"] =
                                  nameController
                                      .text;

                              user![
                                      "lastname"] =
                                  lastnameController
                                      .text;

                              user!["phone"] =
                                  phoneController
                                      .text;

                              user![
                                      "nationality"] =
                                  nationalityController
                                      .text;

                              user![
                                      "document_number"] =
                                  documentController
                                      .text;

                              user![
                                      "avatar_url"] =
                                  avatarController
                                      .text;
                            });

                            Navigator.pop(
                                context);

                            ScaffoldMessenger.of(
                                    context)
                                .showSnackBar(

                              const SnackBar(

                                content: Text(
                                  "Perfil actualizado correctamente",
                                ),
                              ),
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
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) {

      return const Scaffold(

        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      bottomNavigationBar:
          const CustomBottomNav(
        currentIndex: 1,
      ),

      body: SafeArea(

        child:
            SingleChildScrollView(

          padding:
              const EdgeInsets.all(
                  20),

          child: Column(
            children: [

              const SizedBox(
                  height: 10),

              /// TITULO
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

              /// HEADER CARD
              Container(

                width:
                    double.infinity,

                padding:
                    const EdgeInsets.all(
                        24),

                decoration:
                    BoxDecoration(

                  gradient:
                      const LinearGradient(
                    colors: [
                      Color(0xFFFFF3CD),
                      Color(0xFFFFE082),
                    ],
                  ),

                  borderRadius:
                      BorderRadius.circular(
                          30),
                ),

                child: Column(
                  children: [

                    /// AVATAR
                    Stack(

                      children: [

                        CircleAvatar(

                          radius: 55,

                          backgroundColor:
                              Colors.grey
                                  .shade200,

                          backgroundImage:
                              NetworkImage(
                            user![
                                "avatar_url"],
                          ),
                        ),

                        Positioned(

                          bottom: 0,
                          right: 0,

                          child:
                              GestureDetector(

                            onTap:
                                openEditModal,

                            child: Container(

                              padding:
                                  const EdgeInsets
                                      .all(
                                          8),

                              decoration:
                                  BoxDecoration(

                                color: Colors
                                    .blue,

                                shape:
                                    BoxShape
                                        .circle,

                                border:
                                    Border
                                        .all(
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
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 18),

                    /// NAME
                    Text(

                      "${user!["name"]} ${user!["lastname"]}",

                      textAlign:
                          TextAlign.center,

                      style:
                          const TextStyle(
                        fontSize: 26,

                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                        height: 14),

                    /// STARS
                    Container(

                      padding:
                          const EdgeInsets
                              .symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),

                      decoration:
                          BoxDecoration(

                        color:
                            Colors.white,

                        borderRadius:
                            BorderRadius
                                .circular(
                                    30),
                      ),

                      child: Row(

                        mainAxisSize:
                            MainAxisSize.min,

                        children: [

                          const Icon(
                            Icons.star,

                            color:
                                Colors.amber,
                          ),

                          const SizedBox(
                              width: 8),

                          Text(

                            "${user!["stars"]} Estrellas",

                            style:
                                const TextStyle(
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                  height: 28),

              /// INFO CARD
              Card(

                child: Column(
                  children: [

                    InfoTile(
                      icon:
                          Icons.person,

                      title: "Nombre",

                      value:
                          "${user!["name"]} ${user!["lastname"]}",
                    ),

                    const Divider(),

                    InfoTile(
                      icon:
                          Icons.email,

                      title:
                          "Correo",

                      value:
                          user!["email"],
                    ),

                    const Divider(),

                    InfoTile(
                      icon:
                          Icons.phone,

                      title:
                          "Teléfono",

                      value:
                          user!["phone"],
                    ),

                    const Divider(),

                    InfoTile(
                      icon:
                          Icons.badge,

                      title:
                          "Documento",

                      value:
                          user![
                              "document_number"],
                    ),

                    const Divider(),

                    InfoTile(
                      icon:
                          Icons.flag,

                      title:
                          "Nacionalidad",

                      value:
                          user![
                              "nationality"],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                  height: 24),

              /// BUTTON
              SizedBox(

                width:
                    double.infinity,

                child:
                    ElevatedButton.icon(

                  onPressed:
                      openEditModal,

                  icon: const Icon(
                    Icons.edit,
                  ),

                  label: const Text(
                    "Editar Perfil",
                  ),

                  style:
                      ElevatedButton
                          .styleFrom(

                    padding:
                        const EdgeInsets
                            .symmetric(
                      vertical: 18,
                    ),

                    shape:
                        RoundedRectangleBorder(

                      borderRadius:
                          BorderRadius
                              .circular(
                                  20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HistoryPage()),
                    );
                  },
                  icon: const Icon(Icons.history),
                  label: const Text("Ver historial"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}