import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hotel_ya/configs/generic_response.dart';
import 'package:hotel_ya/models/user_model.dart';
import 'package:hotel_ya/services/session_service.dart';

class AuthService {
  Future<GenericResponse<UserModel>> loginWithEmail(
    String email,
    String password,
  ) async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/json/users.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);

      final userJson = jsonList.firstWhere(
        (u) => u['email'] == email && u['password_hash'] == password,
      );

      final user = UserModel.fromJson(userJson);

      SessionService.currentUserId = user.id;
      return GenericResponse(
        success: true,
        data: user,
        message: "Inicio de sesión exitoso",
      );
    } catch (e) {
      return GenericResponse(
        success: false,
        error: e.toString(),
        message: "Error al iniciar sesión",
      );
    }
  }

  Future<GenericResponse<UserModel>> registerWithEmail(
    String email,
    String password,
  ) async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/json/users.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);

      final emailExists = jsonList.any((u) => u['email'] == email);

      if (emailExists) {
        return GenericResponse(
          success: false,
          message: 'Ya existe una cuenta con ese correo',
        );
      }

      final newUser = UserModel(
        id: 'u_${DateTime.now().millisecondsSinceEpoch}',
        email: email,
        passwordHash: password,
        name: 'name',
        lastname: 'lastname',
        phone: 'phone',
        documentType: '',
        documentNumber: '',
        avatarUrl: 'https://i.pravatar.cc/300',
        nationality: '',
        starsAvailable: 0,
      );

      jsonList.add(newUser.toJson());

      SessionService.currentUserId = newUser.id;

      return GenericResponse(
        success: true,
        data: newUser,
        message: 'Usuario registrado exitosamente',
      );
    } catch (e) {
      return GenericResponse(
        success: false,
        error: e.toString(),
        message: "Error al registrar",
      );
    }
  }

  void logout() {
    SessionService.currentUserId = '';
  }
}
