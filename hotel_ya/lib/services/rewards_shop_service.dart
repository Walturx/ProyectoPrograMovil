// lib/services/rewards_shop_service.dart

import 'dart:convert';

import 'package:flutter/services.dart';

/// MODELS
import '../models/user_model.dart';
import '../models/reward_model.dart';

/// CONFIGS
import '../configs/generic_response.dart';

/// SESSION
import 'session_service.dart';

class RewardsShopService {
  /// FETCH USER
  Future<GenericResponse<UserModel>> fetchUser() async {
    try {
      /// LOAD JSON
      String jsonString = await rootBundle.loadString('assets/json/users.json');

      /// PARSE JSON
      final List<dynamic> jsonList = json.decode(jsonString);

      /// CURRENT USER
      final UserModel user = UserModel.fromJson(
        jsonList.firstWhere((u) => u["id"] == SessionService.currentUserId),
      );

      return GenericResponse(
        success: true,
        data: user,
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

  /// FETCH REWARDS
  Future<GenericResponse<List<RewardModel>>> fetchRewards() async {
    try {
      /// LOAD JSON
      String jsonString = await rootBundle.loadString(
        'assets/json/rewards.json',
      );

      /// PARSE JSON
      final List<dynamic> jsonList = json.decode(jsonString);

      /// CONVERT TO MODEL
      final rewards = jsonList.map((json) {
        return RewardModel.fromJson(json);
      }).toList();

      return GenericResponse(
        success: true,
        data: rewards,
        message: 'Recompensas cargadas correctamente',
      );
    } catch (e) {
      return GenericResponse(
        success: false,
        error: e.toString(),
        message: 'Error al cargar recompensas',
      );
    }
  }
}
