// lib/services/profile_service.dart

import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/user_model.dart';

class ProfileService {

  Future<UserModel> fetchUser() async {

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
        'ERROR PROFILE SERVICE:',
      );

      print(e);

      rethrow;
    }
  }
}