// lib/pages/history/history_page.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// CONTROLLER
import 'history_controller.dart';

/// COMPONENTS
import '../../components/history/reservation_card.dart';

import '../../components/history/transaction_card.dart';

/// NAVBAR
import '../../components/custom_bottom_nav.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  /// CONTROLLER
  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      /// LOADING
      if (controller.isLoading.value) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      return Scaffold(
        backgroundColor: const Color(0xFFF8F6F1),

        bottomNavigationBar: const CustomBottomNav(currentIndex: 1),

        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 28),

                /// RESERVATIONS TITLE
                const Text(
                  "Reservas",

                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 18),

                /// RESERVATIONS
                if (controller.reservations.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),

                      child: Text("No hay reservas"),
                    ),
                  )
                else
                  ...List.generate(controller.reservations.length, (index) {
                    final reservation = controller.reservations[index];

                    return ReservationCard(
                      reservation: reservation,

                      hotelName: controller.getHotelName(reservation.roomId),

                      roomTypeName: controller.getRoomTypeName(
                        reservation.roomId,
                      ),

                      status: controller.getReservationStatus(
                        reservation.checkOut,
                      ),

                      statusColor: controller.getReservationStatusColor(
                        controller.getReservationStatus(reservation.checkOut),
                      ),

                      formattedStatus: controller.formatStatus(
                        controller.getReservationStatus(reservation.checkOut),
                      ),
                    );
                  }),

                const SizedBox(height: 30),

                /// TRANSACTIONS TITLE
                const Text(
                  "Movimientos",

                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 18),

                /// TRANSACTIONS
                if (controller.loyaltyTransactions.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),

                      child: Text("No hay movimientos"),
                    ),
                  )
                else
                  ...List.generate(controller.loyaltyTransactions.length, (
                    index,
                  ) {
                    final transaction = controller.loyaltyTransactions[index];

                    return TransactionCard(
                      transaction: transaction,

                      icon: controller.getTransactionIcon(transaction.type),

                      color: controller.getTransactionColor(transaction.type),

                      formattedStars: transaction.type == "earned"
                          ? "+${transaction.stars} ⭐"
                          : "-${transaction.stars} ⭐",
                    );
                  }),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      );
    });
  }
}
