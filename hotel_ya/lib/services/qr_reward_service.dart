// lib/services/qr_reward_service.dart

import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/reward_model.dart';
import '../configs/generic_response.dart';
import 'session_service.dart';

class QRRewardService {
  /// LOAD USER
  Future<GenericResponse<Map<String, dynamic>>> fetchUser() async {
    try {
      final String response = await rootBundle.loadString(
        'assets/json/users.json',
      );
      final List<dynamic> data = json.decode(response);
      final user = data.firstWhere(
        (user) => user["id"] == SessionService.currentUserId,
      );

      return GenericResponse(
        success: true,
        data: Map<String, dynamic>.from(user),
        message: 'Usuario cargado correctamente',
      );
    } catch (e) {
      return GenericResponse(
        success: false,
        error: e.toString(),
        message: 'Error al cargar usuario',
      );
    }
  }

  /// GENERATE QR DATA
  String generateQRData({
    required String userId,
    required RewardModel reward,
    required int remainingStars,
  }) {
    return jsonEncode({
      "reward_id": reward.id,
      "reward": reward.name,
      "stars": reward.starsCost,
      "remaining": remainingStars,
      "user": userId,
    });
  }
}
