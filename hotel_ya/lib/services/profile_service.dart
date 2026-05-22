// lib/services/profile_service.dart

import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/user_model.dart';

class ProfileService {
  // Cache en memoria — persiste durante la sesión
  UserModel? _cachedUser;

  Future<UserModel> fetchUser() async {
    if (_cachedUser != null) return _cachedUser!;

    try {
      final String jsonString =
          await rootBundle.loadString('assets/json/users.json');
      final List<dynamic> jsonList = json.decode(jsonString);
      _cachedUser = UserModel.fromJson(jsonList[0]);
      return _cachedUser!;
    } catch (e) {
      rethrow;
    }
  }

  // Guarda los cambios en el cache — los mantiene mientras la app esté abierta
  void updateUser(UserModel updated) {
    _cachedUser = updated;
  }
}