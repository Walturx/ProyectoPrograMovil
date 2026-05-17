// lib/components/qr_reward/qr_reward_qr_card.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:qr_flutter/qr_flutter.dart';

/// CONTROLLER
import '../../pages/qr_reward/qr_reward_controller.dart';

class QRRewardQRCard
    extends StatelessWidget {

  const QRRewardQRCard({
    super.key,
  });

  @override
  Widget build(
      BuildContext context) {

    /// CONTROLLER
    final QRRewardController
        controller =
            Get.find<
                QRRewardController>();

    return Obx(() {

      return Container(

        width:
            double.infinity,

        padding:
            const EdgeInsets.all(
                24),

        decoration:
            BoxDecoration(

          color:
              Colors.white,

          borderRadius:
              BorderRadius.circular(
                  30),

          boxShadow: [

            BoxShadow(

              color: Colors
                  .black
                  .withOpacity(
                      0.05),

              blurRadius:
                  10,
            ),
          ],
        ),

        child: Column(
          children: [

            /// QR
            Container(

              padding:
                  const EdgeInsets
                      .all(30),

              decoration:
                  BoxDecoration(

                color:
                    Colors.white,

                borderRadius:
                    BorderRadius
                        .circular(
                            24),
              ),

              child: QrImageView(

                data:
                    controller
                        .qrData
                        .value,

                version:
                    QrVersions.auto,

                size: 320,

                backgroundColor:
                    Colors.white,
              ),
            ),

            const SizedBox(
                height: 30),

            /// STARS
            Container(

              padding:
                  const EdgeInsets
                      .symmetric(
                horizontal: 24,
                vertical: 16,
              ),

              decoration:
                  BoxDecoration(

                color:
                    const Color(
                        0xFFFFF8E1),

                borderRadius:
                    BorderRadius
                        .circular(
                            20),
              ),

              child: Row(

                mainAxisSize:
                    MainAxisSize.min,

                children: [

                  Text(

                    "${controller.remainingStars}",

                    style:
                        const TextStyle(
                      fontSize:
                          32,

                      fontWeight:
                          FontWeight
                              .bold,
                    ),
                  ),

                  const SizedBox(
                      width: 10),

                  const Icon(

                    Icons.star,

                    color:
                        Colors.amber,

                    size: 34,
                  ),

                  const SizedBox(
                      width: 10),

                  Text(

                    "restantes",

                    style:
                        TextStyle(
                      fontSize:
                          16,

                      color: Colors
                          .grey
                          .shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}