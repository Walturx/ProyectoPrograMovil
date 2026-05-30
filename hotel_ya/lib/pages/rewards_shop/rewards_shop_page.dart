// lib/pages/rewards_shop/rewards_shop_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

/// CONTROLLER
import 'rewards_shop_controller.dart';

/// COMPONENTS
import '../../components/rewards/rewards_summary_card.dart';
import '../../components/rewards/reward_card.dart';
import '../../components/rewards/rewards_footer.dart';

/// NAVBAR
import '../../components/custom_bottom_nav.dart';




class RewardsShopPage extends StatelessWidget {
  RewardsShopPage({super.key});

  /// CONTROLLER
  final RewardsShopController controller = Get.put(RewardsShopController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      /// LOADING
      if (controller.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      return Scaffold(
        backgroundColor: const Color(0xFFF8F6F1),

        bottomNavigationBar: const CustomBottomNav(currentIndex: 2),

        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const SizedBox(height: 10),

                  /// TITLE
                  const Text(
                    "Rewards Shop",

                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Redeem your stars for rewards",

                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 30),

                  /// SUMMARY
                  RewardsSummaryCard(
                    stars: controller.userStars,
                    remainingStars: controller.remainingStars,
                  ),

                  const SizedBox(height: 30),

                  /// REWARDS LIST
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.rewards.length,
                    separatorBuilder: (_, __) {
                      return const SizedBox(height: 18);
                    },

                    itemBuilder: (_, index) {
                      final reward = controller.rewards[index];

                      return RewardCard(
                        reward: reward,

                        isSelected: controller.isSelected(index),

                        canAfford: controller.canAfford(reward),

                        icon: controller.getRewardIcon(reward.type),

                        onTap: () {
                          controller.selectReward(index);
                        },
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  /// FOOTER
                  RewardsFooter(
                    selectedCost: controller.selectedCost,
                    hasSelection: controller.selectedReward != null,
                    onContinue: () {
                      context.push('/qr');
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
