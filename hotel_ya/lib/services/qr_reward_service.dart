// lib/services/qr_reward_service.dart

import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/reward_model.dart';

class QRRewardService {

  /// LOAD USER
  Future<Map<String, dynamic>>
      fetchUser() async {

    final String response =
        await rootBundle.loadString(
      'assets/json/users.json',
    );

    final data =
        json.decode(response);

    return data[0];
  }

  /// GENERATE QR DATA
  String generateQRData({

    required String  userId,

    required RewardModel reward,

    required int remainingStars,
  }) {

    return jsonEncode({

      "reward_id":
          reward.id,

      "reward":
          reward.name,

      "stars":
          reward.starsCost,

      "remaining":
          remainingStars,

      "user":
          userId,
    });
  }
}