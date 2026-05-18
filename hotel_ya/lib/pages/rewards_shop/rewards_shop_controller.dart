// lib/pages/rewards_shop/rewards_shop_controller.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// MODELS
import '../../models/user_model.dart';

import '../../models/reward_model.dart';

/// SERVICE
import '../../services/rewards_shop_service.dart';

class RewardsShopController
    extends GetxController {

  /// SERVICE
  final RewardsShopService
      rewardsShopService =
          RewardsShopService();

  /// LOADING
  final RxBool isLoading =
      true.obs;

  /// USER
  final Rxn<UserModel> user =
      Rxn<UserModel>();

  /// REWARDS
  final RxList<RewardModel>
      rewards =
          <RewardModel>[].obs;

  /// SELECTED REWARD
  final RxInt selectedIndex =
      (-1).obs;

  @override
  void onInit() {

    super.onInit();

    /// LOAD DATA
    loadData();
  }

  /// LOAD DATA
  Future<void> loadData()
      async {

    try {

      /// START LOADING
      isLoading.value =
          true;

      /// FETCH USER
      final loadedUser =
          await rewardsShopService
              .fetchUser();

      /// FETCH REWARDS
      final loadedRewards =
          await rewardsShopService
              .fetchRewards();

      /// ASSIGN USER
      user.value =
          loadedUser;

      /// ASSIGN REWARDS
      rewards.assignAll(
          loadedRewards);

    } catch (e) {

      print(
        'ERROR REWARDS SHOP CONTROLLER:',
      );

      print(e);

      Get.snackbar(
        'Error',
        'Failed to load rewards',
      );

    } finally {

      /// FINISH LOADING
      isLoading.value =
          false;
    }
  }

  /// SELECT REWARD
  void selectReward(
      int index) {

    /// INVALID INDEX
    if (index < 0 ||
        index >= rewards.length) {

      return;
    }

    /// CANNOT AFFORD
    if (!canAfford(
        rewards[index])) {

      return;
    }

    if (selectedIndex.value ==
        index) {

      /// DESELECT
      selectedIndex.value =
          -1;

    } else {

      /// SELECT
      selectedIndex.value =
          index;
    }
  }

  /// GET SELECTED REWARD
  RewardModel?
      get selectedReward {

    if (selectedIndex.value ==
        -1) {

      return null;
    }

    if (selectedIndex.value >=
        rewards.length) {

      return null;
    }

    return rewards[
        selectedIndex.value];
  }

  /// GET USER STARS
  int get userStars {

    return user.value
            ?.starsAvailable ??
        0;
  }

  /// GET SELECTED COST
  int get selectedCost {

    return selectedReward
            ?.starsCost ??
        0;
  }

  /// GET REMAINING STARS
  int get remainingStars {

    return userStars -
        selectedCost;
  }

  /// IS SELECTED
  bool isSelected(
      int index) {

    return selectedIndex.value ==
        index;
  }

  /// CAN AFFORD
  bool canAfford(
      RewardModel reward) {

    return userStars >=
        reward.starsCost;
  }

  /// GET REWARD ICON
  IconData getRewardIcon(
      String type) {

    switch (type) {

      case "food":
        return Icons.icecream;

      case "drink":
        return Icons.local_drink;

      case "hotel":
        return Icons.hotel;

      default:
        return Icons.card_giftcard;
    }
  }
}

