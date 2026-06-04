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
  /// Suma estrellas al usuario actual en el cache.
  /// Llama a fetchUser primero si el cache está vacío.
  Future<GenericResponse<UserModel>> addStars(int stars) async {
    try {
      // Asegurarse de tener el usuario en cache
      final fetchResponse = await fetchUser();

      if (!fetchResponse.success || !fetchResponse.hasData) {
        return GenericResponse(
          success: false,
          message: 'No se pudo cargar el usuario para sumar estrellas',
          error: fetchResponse.error,
        );
      }

      final updatedUser = fetchResponse.data!.copyWith(
        starsAvailable: fetchResponse.data!.starsAvailable + stars,
      );

      _cachedUser = updatedUser;

      return GenericResponse(
        success: true,
        data: updatedUser,
        message: 'Estrellas sumadas correctamente',
      );
    } catch (e) {
      return GenericResponse(
        success: false,
        error: e.toString(),
        message: 'Error al sumar estrellas',
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
