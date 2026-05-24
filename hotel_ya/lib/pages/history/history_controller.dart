// lib/pages/history/history_controller.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// MODELS
import '../../models/loyalty_transaction_model.dart';
import '../../models/reservation_model.dart';

/// SERVICE
import '../../services/history_service.dart';

class HistoryController extends GetxController {
  /// HISTORY SERVICE
  final HistoryService historyService = HistoryService();

  /// LOADING
  RxBool isLoading = true.obs;

  /// TRANSACTIONS
  RxList<LoyaltyTransactionModel> loyaltyTransactions =
      <LoyaltyTransactionModel>[].obs;

  /// RESERVATIONS
  RxList<ReservationModel> reservations = <ReservationModel>[].obs;

  /// ROOMS
  RxList<Map<String, dynamic>> rooms = <Map<String, dynamic>>[].obs;

  /// HOTELS
  RxList<Map<String, dynamic>> hotels = <Map<String, dynamic>>[].obs;

  /// ROOM TYPES
  RxList<Map<String, dynamic>> roomTypes = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();

    /// LOAD DATA
    loadData();
  }

  /// LOAD DATA
  Future<void> loadData() async {
    /// FETCH TRANSACTIONS
    final transactionsResponse = await historyService.fetchTransactions();

    /// FETCH RESERVATIONS
    final reservationsResponse = await historyService.fetchReservations();

    /// FETCH ROOMS
    final roomsResponse = await historyService.fetchRooms();

    /// FETCH HOTELS
    final hotelsResponse = await historyService.fetchHotels();

    /// FETCH ROOM TYPES
    final roomTypesResponse = await historyService.fetchRoomTypes();

    /// TRANSACTIONS
    if (transactionsResponse.success && transactionsResponse.hasData) {
      loyaltyTransactions.value = transactionsResponse.data!;
    } else {
      print("ERROR TRANSACTIONS: ${transactionsResponse.error}");
    }

    /// RESERVATIONS
    if (reservationsResponse.success && reservationsResponse.hasData) {
      reservations.value = reservationsResponse.data!;
    } else {
      print("ERROR RESERVATIONS: ${reservationsResponse.error}");
    }

    /// ROOMS
    if (roomsResponse.success && roomsResponse.hasData) {
      rooms.value = roomsResponse.data!;
    } else {
      print("ERROR ROOMS: ${roomsResponse.error}");
    }

    /// HOTELS
    if (hotelsResponse.success && hotelsResponse.hasData) {
      hotels.value = hotelsResponse.data!;
    } else {
      print("ERROR HOTELS: ${hotelsResponse.error}");
    }

    /// ROOM TYPES
    if (roomTypesResponse.success && roomTypesResponse.hasData) {
      roomTypes.value = roomTypesResponse.data!;
    } else {
      print("ERROR ROOM TYPES: ${roomTypesResponse.error}");
    }

    /// FINISH LOADING
    isLoading.value = false;
  }

  /// TRANSACTION ICON
  IconData getTransactionIcon(String type) {
    switch (type) {
      case "earned":
        return Icons.add_circle;

      case "spent":
        return Icons.remove_circle;

      default:
        return Icons.star;
    }
  }

  /// TRANSACTION COLOR
  Color getTransactionColor(String type) {
    switch (type) {
      case "earned":
        return Colors.green;

      case "spent":
        return Colors.redAccent;

      default:
        return Colors.amber;
    }
  }

  /// RESERVATION STATUS
  String getReservationStatus(DateTime checkOut) {
    final DateTime now = DateTime.now();

    if (checkOut.isBefore(now)) {
      return "completed";
    }

    return "pending";
  }

  /// STATUS COLOR
  Color getReservationStatusColor(String status) {
    switch (status) {
      case "completed":
        return Colors.green;

      case "pending":
        return Colors.orange;

      default:
        return Colors.blue;
    }
  }

  /// FORMAT STATUS
  String formatStatus(String status) {
    switch (status) {
      case "completed":
        return "Completada";

      case "pending":
        return "Pendiente";

      default:
        return "Activa";
    }
  }

  /// GET HOTEL NAME
  String getHotelName(String roomId) {
    final room = rooms.firstWhere(
      (room) => room["id"] == roomId,

      orElse: () => {},
    );

    if (room.isEmpty) {
      return "Hotel";
    }

    final hotel = hotels.firstWhere(
      (hotel) => hotel["id"] == room["hotel_id"],

      orElse: () => {},
    );

    if (hotel.isEmpty) {
      return "Hotel";
    }

    return hotel["name"];
  }

  /// GET ROOM TYPE NAME
  String getRoomTypeName(String roomId) {
    final room = rooms.firstWhere(
      (room) => room["id"] == roomId,

      orElse: () => {},
    );

    if (room.isEmpty) {
      return "Habitación";
    }

    final roomType = roomTypes.firstWhere(
      (type) => type["id"] == room["room_type_id"],

      orElse: () => {},
    );

    if (roomType.isEmpty) {
      return "Habitación";
    }

    return roomType["name"];
  }
}
