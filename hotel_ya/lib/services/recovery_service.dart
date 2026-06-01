// lib/services/recovery_service.dart

import 'dart:convert';
import 'package:flutter/services.dart';

/// CONFIGS
import '../configs/generic_response.dart';

class RecoveryService {
  Future<GenericResponse<String>> sendCode(String email) async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/json/users.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);

      jsonList.firstWhere((u) => u['email'] == email);

      return GenericResponse(
        success: true,
        data: 'recovery_token_mock',
        message: 'Código enviado al correo',
      );
    } catch (e) {
      return GenericResponse(
        success: false,
        message: 'No existe una cuenta con ese correo',
        error: e.toString(),
      );
    }
  }

  Future<GenericResponse<String>> validateCode(
    String token,
    String code,
  ) async {
    try {
      if (code == '1234') {
        return GenericResponse(
          success: true,
          data: token,
          message: 'Código validado correctamente',
        );
      } else {
        return GenericResponse(success: false, message: 'Código incorrecto');
      }
    } catch (e) {
      return GenericResponse(
        success: false,
        message: 'Error al validar código',
        error: e.toString(),
      );
    }
  }

  Future<GenericResponse<String>> changePassword(
    String token,
    String newPassword,
    String confirmPassword,
  ) async {
    try {
      if (newPassword != confirmPassword) {
        return GenericResponse(
          success: false,
          message: 'Las contraseñas no coinciden',
        );
      }

      return GenericResponse(
        success: true,
        data: token,
        message: 'Contraseña cambiada correctamente',
      );
    } catch (e) {
      return GenericResponse(
        success: false,
        message: 'Error al cambiar contraseña',
        error: e.toString(),
      );
    }
  }
}
