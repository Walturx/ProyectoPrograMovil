// lib/services/history_service.dart

import 'dart:convert';

import 'package:flutter/services.dart';

/// MODELS
import '../models/loyalty_transaction_model.dart';

import '../models/reservation_model.dart';

class HistoryService {

  /// FETCH LOYALTY TRANSACTIONS
  Future<List<LoyaltyTransactionModel>>
      fetchTransactions() async {

    try {

      /// LOAD JSON
      String jsonString =
          await rootBundle.loadString(

        'assets/json/loyalty_transactions.json',
      );

      /// PARSE JSON
      final List<dynamic> jsonList =
          json.decode(jsonString);

      /// CONVERT TO MODEL
      final transactions =
          jsonList.map((json) {

        return LoyaltyTransactionModel.fromJson({

          ...json,

          'reservation_id':
              json['reservation_id'] ?? "",

          'reward_redemption_id':
              json['reward_redemption_id'] ?? "",
        });

      }).toList();

      return transactions;

    } catch (e) {

      print(
        'ERROR FETCH TRANSACTIONS:',
      );

      print(e);

      rethrow;
    }
  }

  /// FETCH RESERVATIONS
  Future<List<ReservationModel>>
      fetchReservations() async {

    try {

      /// LOAD JSON
      String jsonString =
          await rootBundle.loadString(

        'assets/json/reservations.json',
      );

      /// PARSE JSON
      final List<dynamic> jsonList =
          json.decode(jsonString);

      /// CONVERT TO MODEL
      final reservations =
          jsonList.map((json) {

        return ReservationModel.fromJson({

          ...json,

          'room_id':
              json['room_id'] ?? "",

          'status':
              json['status'] ?? "",

          'special_requests':
              json['special_requests'] ?? "",
        });

      }).toList();

      return reservations;

    } catch (e) {

      print(
        'ERROR FETCH RESERVATIONS:',
      );

      print(e);

      rethrow;
    }
  }
}