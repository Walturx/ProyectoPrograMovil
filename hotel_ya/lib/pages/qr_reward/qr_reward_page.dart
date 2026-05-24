// lib/pages/qr_reward/qr_reward_page.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// CONTROLLER
import 'qr_reward_controller.dart';

/// COMPONENTS
import '../../components/qr_reward/qr_reward_header.dart';
import '../../components/qr_reward/qr_reward_product_card.dart';
import '../../components/qr_reward/qr_reward_qr_card.dart';

/// NAVBAR
import '../../components/custom_bottom_nav.dart';

class QRRewardPage extends StatelessWidget {
  QRRewardPage({super.key});

  /// CONTROLLER
  final QRRewardController controller = Get.put(QRRewardController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      /// LOADING
      if (controller.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      /// NO REWARD
      if (controller.selectedReward == null) {
        return const Scaffold(body: Center(child: Text("No reward selected")));
      }

      return Scaffold(
        backgroundColor: const Color(0xFFF8F6F1),

        bottomNavigationBar: const CustomBottomNav(currentIndex: 2),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  const SizedBox(height: 20),

                  /// HEADER
                  const QRRewardHeader(),

                  const SizedBox(height: 30),

                  /// PRODUCT CARD
                  QRRewardProductCard(
                    reward: controller.selectedReward!,

                    icon: controller.rewardsShopController.getRewardIcon(
                      controller.selectedReward!.type,
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// QR CARD
                  QRRewardQRCard(
                    qrData: controller.qrData.value,

                    remainingStars: controller.remainingStars,
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
