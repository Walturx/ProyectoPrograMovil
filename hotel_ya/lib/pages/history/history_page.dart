// lib/pages/history/history_page.dart

import 'package:flutter/material.dart';

import 'package:get/get.dart';

/// CONTROLLER
import 'history_controller.dart';

/// COMPONENTS
import '../../components/custom_bottom_nav.dart';

import '../../components/history/transaction_card.dart';

import '../../components/history/reservation_card.dart';

class HistoryPage
    extends StatelessWidget {

  HistoryPage({super.key});

  /// GETX CONTROLLER
  final HistoryController
      controller =
          Get.put(
    HistoryController(),
  );

  /// BUILD BODY
  Widget _buildBody(
    BuildContext context,
  ) {

    return SafeArea(

      child:
          SingleChildScrollView(

        padding:
            const EdgeInsets.all(
                20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment
                  .start,

          children: [

            const SizedBox(
                height: 10),

            /// TITLE
            const Text(

              "Historial",

              style: TextStyle(
                fontSize: 32,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 8),

            Text(

              "Actividad reciente de tu cuenta",

              style: TextStyle(

                color:
                    Colors.grey
                        .shade600,

                fontSize: 16,
              ),
            ),

            const SizedBox(
                height: 32),

            /// TRANSACTIONS
            const Text(

              "Movimientos de Estrellas",

              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 18),

            ListView.builder(

              itemCount:
                  controller
                      .loyaltyTransactions
                      .length,

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              itemBuilder:
                  (context, index) {

                final transaction =
                    controller
                        .loyaltyTransactions[
                            index];

                return TransactionCard(

                  transaction:
                      transaction,

                  controller:
                      controller,
                );
              },
            ),

            const SizedBox(
                height: 36),

            /// RESERVATIONS
            const Text(

              "Historial de Reservas",

              style: TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
                height: 18),

            ListView.builder(

              itemCount:
                  controller
                      .reservations
                      .length,

              shrinkWrap: true,

              physics:
                  const NeverScrollableScrollPhysics(),

              itemBuilder:
                  (context, index) {

                final reservation =
                    controller
                        .reservations[
                            index];

                return ReservationCard(

                  reservation:
                      reservation,

                  controller:
                      controller,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) {

    return Obx(() {

      /// LOADING
      if (controller
          .isLoading.value) {

        return const Scaffold(

          body: Center(

            child:
                CircularProgressIndicator(),
          ),
        );
      }

      return Scaffold(

        /// BOTTOM NAV
        bottomNavigationBar:
            const CustomBottomNav(
          currentIndex: 1,
        ),

        /// BODY
        body:
            _buildBody(
          context,
        ),
      );
    });
  }
}