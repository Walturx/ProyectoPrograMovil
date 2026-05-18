// lib/components/qr_reward/qr_reward_product_card.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// CONTROLLER
import '../../pages/qr_reward/qr_reward_controller.dart';

class QRRewardProductCard
    extends StatelessWidget {

  const QRRewardProductCard({
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

      /// REWARD
      final reward =
          controller
              .selectedReward;

      if (reward == null) {

        return const SizedBox();
      }

      /// REWARD TYPE
      final String rewardType =
          reward.type;

      return Column(

        children: [

          /// ICONO TOP
          Container(

            padding:
                const EdgeInsets
                    .all(18),

            decoration:
                BoxDecoration(

              color:
                  const Color(
                      0xFFFFF3CD),

              borderRadius:
                  BorderRadius.circular(
                      24),
            ),

            child: Icon(

              controller
                  .rewardsShopController
                  .getRewardIcon(
                rewardType,
              ),

              size: 50,

              color:
                  const Color(
                      0xFFD4AF37),
            ),
          ),

          const SizedBox(
              height: 30),

          /// PRODUCTO
          Container(

            padding:
                const EdgeInsets
                    .all(18),

            decoration:
                BoxDecoration(

              color:
                  Colors.white,

              borderRadius:
                  BorderRadius.circular(
                      24),

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

            child: Row(
              children: [

                /// ICONO
                Container(

                  padding:
                      const EdgeInsets
                          .all(14),

                  decoration:
                      BoxDecoration(

                    color:
                        const Color(
                            0xFFFFF3CD),

                    borderRadius:
                        BorderRadius
                            .circular(
                                18),
                  ),

                  child: Icon(

                    controller
                        .rewardsShopController
                        .getRewardIcon(
                      rewardType,
                    ),

                    size: 34,

                    color:
                        const Color(
                            0xFFD4AF37),
                  ),
                ),

                const SizedBox(
                    width: 18),

                /// TEXTOS
                Expanded(

                  child: Column(

                    crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                    children: [

                      const Text(

                        "Premio Canjeado",

                        style:
                            TextStyle(
                          color:
                              Colors.grey,
                        ),
                      ),

                      const SizedBox(
                          height: 6),

                      Text(

                        reward.name,

                        style:
                            const TextStyle(
                          fontSize:
                              20,

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
              height: 30),
        ],
      );
    });
  }
}