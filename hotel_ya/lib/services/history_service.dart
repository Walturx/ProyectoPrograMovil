// lib/services/history_service.dart

import 'dart:convert';

import 'package:flutter/services.dart';

/// MODELS
import '../models/loyalty_transaction_model.dart';
import '../models/reservation_model.dart';

/// CONFIGS
import '../configs/generic_response.dart';

/// SESSION
import 'session_service.dart';

class HistoryService {
  /// FETCH LOYALTY TRANSACTIONS
  Future<GenericResponse<List<LoyaltyTransactionModel>>>
  fetchTransactions() async {
    try {
      /// LOAD JSON
      String jsonString = await rootBundle.loadString(
        'assets/json/loyalty_transactions.json',
      );

      /// PARSE JSON
      final List<dynamic> jsonList = json.decode(jsonString);

      /// CONVERT TO MODEL (filter by current user)
      final transactions = jsonList
          .where((json) => json['user_id'] == SessionService.currentUserId)
          .map((json) {
            return LoyaltyTransactionModel.fromJson({
              ...json,

              'reservation_id': json['reservation_id'] ?? "",

              'reward_redemption_id': json['reward_redemption_id'] ?? "",
            });
          })
          .toList();

      return GenericResponse(
        success: true,

        data: transactions,

        message: 'Transacciones cargadas correctamente',
      );
    } catch (e) {
      return GenericResponse(
        success: false,

        error: e.toString(),

        message: 'Error al cargar transacciones',
      );
    }
  }

  /// FETCH RESERVATIONS
  Future<GenericResponse<List<ReservationModel>>> fetchReservations() async {
    try {
      /// LOAD JSON
      String jsonString = await rootBundle.loadString(
        'assets/json/reservations.json',
      );

      /// PARSE JSON
      final List<dynamic> jsonList = json.decode(jsonString);

      /// CONVERT TO MODEL (filter by current user)
      final reservations = jsonList
          .where((json) => json['user_id'] == SessionService.currentUserId)
          .map((json) {
            return ReservationModel.fromJson({
              ...json,

              'room_id': json['room_id'] ?? "",

              'status': json['status'] ?? "",

              'special_requests': json['special_requests'] ?? "",
            });
          })
          .toList();

      return GenericResponse(
        success: true,

        data: reservations,

        message: 'Reservaciones cargadas correctamente',
      );
    } catch (e) {
      return GenericResponse(
        success: false,

        error: e.toString(),

        message: 'Error al cargar reservaciones',
      );
    }
  }

  /// FETCH ROOMS
  Future<GenericResponse<List<Map<String, dynamic>>>> fetchRooms() async {
    try {
      /// LOAD JSON
      String jsonString = await rootBundle.loadString('assets/json/rooms.json');

      /// PARSE JSON
      final List<dynamic> jsonList = json.decode(jsonString);

      return GenericResponse(
        success: true,

        data: List<Map<String, dynamic>>.from(jsonList),

        message: 'Habitaciones cargadas correctamente',
      );
    } catch (e) {
      return GenericResponse(
        success: false,

        error: e.toString(),

        message: 'Error al cargar habitaciones',
      );
    }
  }

  /// FETCH HOTELS
  /// FETCH HOTELS
  Future<GenericResponse<List<Map<String, dynamic>>>> fetchHotels() async {
    try {
      /// LOAD JSON
      String jsonString = await rootBundle.loadString(
        'assets/json/hotels.json',
      );

      /// PARSE JSON
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      /// GET HOTELS ARRAY
      final List<dynamic> hotelsList = jsonData['hotels'];

      return GenericResponse(
        success: true,

        data: List<Map<String, dynamic>>.from(hotelsList),

        message: 'Hoteles cargados correctamente',
      );
    } catch (e) {
      return GenericResponse(
        success: false,

        error: e.toString(),

        message: 'Error al cargar hoteles',
      );
    }
  }

  /// FETCH ROOM TYPES
  Future<GenericResponse<List<Map<String, dynamic>>>> fetchRoomTypes() async {
    try {
      /// LOAD JSON
      String jsonString = await rootBundle.loadString(
        'assets/json/room_types.json',
      );

      /// PARSE JSON
      final List<dynamic> jsonList = json.decode(jsonString);

      return GenericResponse(
        success: true,

        data: List<Map<String, dynamic>>.from(jsonList),

        message: 'Tipos de habitación cargados correctamente',
      );
    } catch (e) {
      return GenericResponse(
        success: false,

        error: e.toString(),

        message: 'Error al cargar tipos de habitación',
      );
    }
  }
}
