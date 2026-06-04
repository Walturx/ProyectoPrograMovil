// lib/pages/qr_reward/qr_reward_controller.dart

import 'package:get/get.dart';

/// MODELS
import '../../models/reward_model.dart';

/// SERVICES
import '../../services/qr_reward_service.dart';

/// CONTROLLERS
import '../rewards_shop/rewards_shop_controller.dart';

class QRRewardController extends GetxController {
  /// SERVICE
  final QRRewardService qrRewardService = QRRewardService();

  /// REWARDS SHOP CONTROLLER
  final RewardsShopController rewardsShopController =
      Get.find<RewardsShopController>();

  /// LOADING
  final RxBool isLoading = true.obs;

  /// USER
  final RxMap<String, dynamic> user = <String, dynamic>{}.obs;

  /// QR DATA
  final RxString qrData = ''.obs;

  /// SELECTED REWARD
  RewardModel? get selectedReward {
    return rewardsShopController.selectedReward;
  }

  /// USER STARS
  int get userStars {
    return rewardsShopController.userStars;
  }

  /// REMAINING STARS
  int get remainingStars {
    if (selectedReward == null) {
      return userStars;
    }

    return userStars - selectedReward!.starsCost;
  }

  @override
  void onInit() {
    super.onInit();

    /// LOAD DATA
    loadData();
  }

  /// LOAD DATA
  Future<void> loadData() async {
    try {
      /// START LOADING
      isLoading.value = true;

      /// FETCH USER
      final response = await qrRewardService.fetchUser();

      if (response.success && response.hasData) {
        user.assignAll(response.data!);

        /// GENERATE QR
        generateQR();
      } else {
        print('ERROR QR REWARD: ${response.error}');
      }
    } catch (e) {
      print('ERROR QR REWARD CONTROLLER:');

      print(e);

      Get.snackbar('Error', 'Failed to load QR reward');
    } finally {
      /// FINISH LOADING
      isLoading.value = false;
    }
  }

  /// GENERATE QR

  void generateQR() {
    print("USER STARS: $userStars");
    print("REWARD: ${selectedReward?.name}");
    print("COST: ${selectedReward?.starsCost}");
    print("REMAINING: $remainingStars");

    if (selectedReward == null) {
      return;
    }

    qrData.value = qrRewardService.generateQRData(
      userId: user["id"],
      reward: selectedReward!,
      remainingStars: remainingStars,
    );
  }
}
