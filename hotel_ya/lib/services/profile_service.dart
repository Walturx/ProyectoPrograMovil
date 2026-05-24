// lib/services/profile_service.dart

import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/user_model.dart';

import '../configs/generic_response.dart';

import 'session_service.dart';

class ProfileService {
  // Cache en memoria — persiste durante la sesión
  UserModel? _cachedUser;

  Future<GenericResponse<UserModel>> fetchUser() async {
    if (_cachedUser != null) {
      return GenericResponse(
        success: true,
        data: _cachedUser!,
        message: 'Usuario cargado desde cache',
      );
    }

    try {
      final String jsonString = await rootBundle.loadString(
        'assets/json/users.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);

      final userJson = jsonList.firstWhere(
        (user) => user["id"] == SessionService.currentUserId,
      );

      _cachedUser = UserModel.fromJson(userJson);

      return GenericResponse(
        success: true,
        data: _cachedUser!,
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

  // Guarda los cambios en el cache — los mantiene mientras la app esté abierta
  void updateUser(UserModel updated) {
    _cachedUser = updated;
  }

  // Limpiar cache - logout
  void clearCache() {
    _cachedUser = null;
  }
}
