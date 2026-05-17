// lib/components/qr_reward/qr_reward_footer.dart

import 'package:flutter/material.dart';

class QRRewardFooter
    extends StatelessWidget {

  const QRRewardFooter({
    super.key,
  });

  @override
  Widget build(
      BuildContext context) {

    return Column(

      children: [

        const SizedBox(
            height: 24),

        /// BOTON
        SizedBox(

          width:
              double.infinity,

          child:
              ElevatedButton.icon(

            onPressed: () {},

            icon: const Icon(
              Icons.download,
            ),

            label: const Text(

              "Guardar QR",

              style: TextStyle(
                fontSize: 16,
              ),
            ),

            style:
                ElevatedButton.styleFrom(

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