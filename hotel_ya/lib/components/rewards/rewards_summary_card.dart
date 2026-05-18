// lib/components/rewards/rewards_summary_card.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// CONTROLLER
import '../../pages/rewards_shop/rewards_shop_controller.dart';

class RewardsSummaryCard
    extends StatelessWidget {

  const RewardsSummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    /// CONTROLLER
    final RewardsShopController
        controller =
            Get.find<
                RewardsShopController>();

    return Obx(() {

      return Container(

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
              Color(0xFFFFE082),
              Color(0xFFFFF3CD),
            ],
          ),

          borderRadius:
              BorderRadius.circular(
                  28),
        ),

        child: Row(

          mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

          children: [

            /// AVAILABLE
            Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

              children: [

                Text(

                  "Disponibles",

                  style:
                      TextStyle(

                    color: Colors
                        .grey
                        .shade700,

                    fontSize:
                        16,
                  ),
                ),

                const SizedBox(
                    height: 12),

                Row(
                  children: [

                    Text(

                      "${controller.userStars}",

                      style:
                          const TextStyle(
                        fontSize:
                            42,

                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                        width: 8),

                    const Icon(
                      Icons.star,

                      color:
                          Colors.amber,

                      size: 34,
                    ),
                  ],
                ),
              ],
            ),

            /// REMAINING
            Column(

              crossAxisAlignment:
                  CrossAxisAlignment
                      .end,

              children: [

                Text(

                  "Restantes",

                  style:
                      TextStyle(

                    color: Colors
                        .grey
                        .shade700,

                    fontSize:
                        16,
                  ),
                ),

                const SizedBox(
                    height: 12),

                Row(
                  children: [

                    Text(

                      "${controller.remainingStars}",

                      style:
                          const TextStyle(
                        fontSize:
                            42,

                        fontWeight:
                            FontWeight
                                .bold,
                      ),
                    ),

                    const SizedBox(
                        width: 8),

                    const Icon(
                      Icons.star,

                      color:
                          Colors.amber,

                      size: 34,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}