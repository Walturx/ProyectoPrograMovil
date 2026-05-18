// lib/pages/rewards_shop/rewards_shop_page.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// CONTROLLER
import 'rewards_shop_controller.dart';

/// COMPONENTS
import '../../components/custom_bottom_nav.dart';

import '../../components/rewards/reward_card.dart';

import '../../components/rewards/rewards_summary_card.dart';

import '../../components/rewards/rewards_footer.dart';

class RewardsShopPage
    extends StatelessWidget {

  RewardsShopPage({
    super.key,
  });

  /// GETX CONTROLLER
  final RewardsShopController
      controller =
          Get.find<
              RewardsShopController>();

  /// BUILD BODY
  Widget _buildBody(
    BuildContext context,
  ) {

    return SafeArea(

      child: Padding(

        padding:
            const EdgeInsets.all(
                20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            const SizedBox(
                height: 10),

            /// TITLE
            const Text(

              "Tienda de Estrellas",

              style: TextStyle(
                fontSize: 32,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 28),

            /// SUMMARY CARD
            const RewardsSummaryCard(),

            const SizedBox(
                height: 30),

            /// SUBTITLE
            const Text(

              "Premios disponibles",

              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 20),

            /// REWARDS LIST
            Expanded(

              child: Obx(() {

                return ListView.builder(

                  itemCount:
                      controller
                          .rewards
                          .length,

                  itemBuilder:
                      (context, index) {

                    final reward =
                        controller
                            .rewards[
                                index];

                    return RewardCard(

                      reward:
                          reward,

                      index:
                          index,
                    );
                  },
                );
              }),
            ),

            /// FOOTER
            const RewardsFooter(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return Obx(() {

      /// LOADING
      if (controller
          .isLoading.value) {

        return const Scaffold(

          body: Center(

            child:
                CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(

        /// BOTTOM NAV
        bottomNavigationBar:
            const CustomBottomNav(
          currentIndex: 2,
        ),

        /// BODY
        body:
            _buildBody(
          context,
        ),
      );
    });
  }
}