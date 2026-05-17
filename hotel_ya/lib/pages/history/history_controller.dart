// lib/pages/history/history_controller.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// MODELS
import '../../models/loyalty_transaction_model.dart';

import '../../models/reservation_model.dart';

/// SERVICE
import '../../services/history_service.dart';

class HistoryController
    extends GetxController {

  /// HISTORY SERVICE
  final HistoryService
      historyService =
          HistoryService();

  /// LOADING
  RxBool isLoading =
      true.obs;

  /// TRANSACTIONS
  RxList<LoyaltyTransactionModel>
      loyaltyTransactions =
          <LoyaltyTransactionModel>[]
              .obs;

  /// RESERVATIONS
  RxList<ReservationModel>
      reservations =
          <ReservationModel>[]
              .obs;

  @override
  void onInit() {

    super.onInit();

    /// LOAD DATA
    loadData();
  }

  /// LOAD DATA
  Future<void> loadData()
      async {

    try {

      /// FETCH TRANSACTIONS
      loyaltyTransactions
          .value = await historyService
              .fetchTransactions();

      /// FETCH RESERVATIONS
      reservations.value =
          await historyService
              .fetchReservations();

      /// FINISH LOADING
      isLoading.value =
          false;

    } catch (e) {

      print(
        "ERROR HISTORY CONTROLLER:",
      );

      print(e);
    }
  }

  /// TRANSACTION ICON

  IconData getTransactionIcon(
      String type) {

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

  Color getTransactionColor(
      String type) {

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

  String getReservationStatus(
      DateTime checkOut) {

    final DateTime now =
        DateTime.now();

    if (checkOut.isBefore(now)) {

      return "completed";
    }

    return "pending";
  }

  /// STATUS COLOR


  Color getReservationStatusColor(
      String status) {

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
  String formatStatus(
      String status) {

    switch (status) {

      case "completed":
        return "Completada";

      case "pending":
        return "Pendiente";

      default:
        return "Activa";
    }
  }
}