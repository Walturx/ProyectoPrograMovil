// lib/pages/qr_reward/qr_reward_page.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// COMPONENTS
import '../../components/custom_bottom_nav.dart';

import '../../components/qr_reward/qr_reward_header.dart';

import '../../components/qr_reward/qr_reward_product_card.dart';

import '../../components/qr_reward/qr_reward_qr_card.dart';

import '../../components/qr_reward/qr_reward_footer.dart';

/// CONTROLLER
import 'qr_reward_controller.dart';

class QRRewardPage
    extends StatelessWidget {

  const QRRewardPage({
    super.key,
  });

  /// CONTROLLER
  QRRewardController
    get controller =>
        Get.put(
          QRRewardController(),
        );

  @override
  Widget build(
      BuildContext context) {

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

      /// INVALID REWARD
      if (controller
              .selectedReward ==
          null) {

        return const Scaffold(

          body: Center(

            child: Text(
              "No reward selected",
            ),
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
        body: SafeArea(

          child:
              SingleChildScrollView(

            child: Padding(

              padding:
                  const EdgeInsets.all(
                      20),

              child: Column(

                crossAxisAlignment:
                    CrossAxisAlignment
                        .center,

                children: const [

                  /// HEADER
                  QRRewardHeader(),

                  /// PRODUCT CARD
                  QRRewardProductCard(),

                  /// QR CARD
                  QRRewardQRCard(),

                  /// FOOTER
                  QRRewardFooter(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}