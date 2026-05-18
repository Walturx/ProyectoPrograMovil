// lib/services/rewards_shop_service.dart

import 'dart:convert';

import 'package:flutter/services.dart';

/// MODELS
import '../models/user_model.dart';

import '../models/reward_model.dart';

class RewardsShopService {

  /// FETCH USER
  Future<UserModel>
      fetchUser() async {

    try {

      /// LOAD JSON
      String jsonString =
          await rootBundle.loadString(

        'assets/json/users.json',
      );

      /// PARSE JSON
      final List<dynamic> jsonList =
          json.decode(jsonString);

      /// CURRENT USER
      final UserModel user =
          UserModel.fromJson(
        jsonList[0],
      );

      return user;

    } catch (e) {

      print(
        'ERROR FETCH USER:',
      );

      print(e);

      rethrow;
    }
  }

  /// FETCH REWARDS
  Future<List<RewardModel>>
      fetchRewards() async {

    try {

      /// LOAD JSON
      String jsonString =
          await rootBundle.loadString(

        'assets/json/rewards.json',
      );

      /// PARSE JSON
      final List<dynamic> jsonList =
          json.decode(jsonString);

      /// CONVERT TO MODEL
      final rewards =
          jsonList.map((json) {

        return RewardModel
            .fromJson(json);

      }).toList();

      return rewards;

    } catch (e) {

      print(
        'ERROR FETCH REWARDS:',
      );

      print(e);

      rethrow;
    }
  }
}