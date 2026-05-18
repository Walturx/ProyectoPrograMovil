// lib/components/profile/profile_action_buttons.dart

import 'package:flutter/material.dart';

/// PAGES
import '../../pages/history/history_page.dart';

class ProfileActionButtons
    extends StatelessWidget {

  final VoidCallback
      onEdit;

  const ProfileActionButtons({

    super.key,

    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [

        /// EDIT BUTTON
        SizedBox(

          width:
              double.infinity,

          child:
              ElevatedButton.icon(

            onPressed: onEdit,

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

        const SizedBox(
            height: 16),

        /// HISTORY BUTTON
        SizedBox(

          width:
              double.infinity,

          child:
              ElevatedButton.icon(

            onPressed: () {

              Navigator.push(

                context,

                MaterialPageRoute(

                  builder:
                      (context) =>
                          HistoryPage(),
                ),
              );
            },

            icon: const Icon(
              Icons.history,
            ),

            label: const Text(
              "Ver historial",
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
      ],
    );
  }
}