// lib/pages/history_page.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../widgets/custom_bottom_nav.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() =>
      _HistoryPageState();
}

class _HistoryPageState
    extends State<HistoryPage> {

  List<dynamic> loyaltyTransactions = [];

  List<dynamic> reservations = [];

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {

    /// LOYALTY
    final String loyaltyResponse =
        await rootBundle.loadString(
      'assets/json/loyalty_transactions.json',
    );

    final loyaltyData =
        json.decode(loyaltyResponse);

    /// RESERVATIONS
    final String reservationsResponse =
        await rootBundle.loadString(
      'assets/json/reservations.json',
    );

    final reservationsData =
        json.decode(reservationsResponse);

    setState(() {

      loyaltyTransactions =
          loyaltyData;

      reservations =
          reservationsData;

      isLoading = false;
    });
  }

  /// =========================
  /// ICONOS TRANSACCIONES
  /// =========================

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

  /// =========================
  /// STATUS RESERVA
  /// =========================

  String getReservationStatus(
      String checkOut) {

    final DateTime now =
        DateTime.now();

    final DateTime checkOutDate =
        DateTime.parse(checkOut);

    if (checkOutDate.isBefore(now)) {

      return "completed";
    }

    return "pending";
  }

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

  @override
  Widget build(BuildContext context) {

    if (isLoading) {

      return const Scaffold(
        body: Center(
          child:
              CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(

      bottomNavigationBar:
          const CustomBottomNav(
        currentIndex: 1,
      ),

      body: SafeArea(
        child: SingleChildScrollView(

          padding:
              const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 10),

              /// TITULO
              const Text(
                "Historial",

                style: TextStyle(
                  fontSize: 32,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Actividad reciente de tu cuenta",

                style: TextStyle(
                  color:
                      Colors.grey.shade600,

                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 32),

              /// =========================
              /// MOVIMIENTOS ESTRELLAS
              /// =========================

              const Text(
                "Movimientos de Estrellas",

                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              ListView.builder(

                itemCount:
                    loyaltyTransactions.length,

                shrinkWrap: true,

                physics:
                    const NeverScrollableScrollPhysics(),

                itemBuilder:
                    (context, index) {

                  final transaction =
                      loyaltyTransactions[
                          index];

                  final String type =
                      transaction["type"];

                  final int stars =
                      transaction["stars"];

                  return Container(

                    margin:
                        const EdgeInsets.only(
                            bottom: 18),

                    padding:
                        const EdgeInsets.all(
                            18),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                              24),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.05),

                          blurRadius: 10,

                          offset:
                              const Offset(
                                  0, 4),
                        ),
                      ],
                    ),

                    child: Row(
                      children: [

                        /// ICONO
                        Container(

                          padding:
                              const EdgeInsets
                                  .all(16),

                          decoration:
                              BoxDecoration(

                            color:
                                getTransactionColor(
                                        type)
                                    .withOpacity(
                                        0.15),

                            borderRadius:
                                BorderRadius
                                    .circular(
                                        18),
                          ),

                          child: Icon(

                            getTransactionIcon(
                                type),

                            size: 34,

                            color:
                                getTransactionColor(
                                    type),
                          ),
                        ),

                        const SizedBox(
                            width: 18),

                        /// TEXTOS
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(

                                transaction[
                                    "description"],

                                style:
                                    const TextStyle(
                                  fontSize: 18,

                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              const SizedBox(
                                  height: 6),

                              if (transaction[
                                      "hotel_name"] !=
                                  null)

                                Text(

                                  transaction[
                                      "hotel_name"],

                                  style:
                                      TextStyle(
                                    color: Colors
                                        .grey
                                        .shade700,
                                  ),
                                ),

                              const SizedBox(
                                  height: 10),

                              Text(

                                transaction[
                                    "created_at"],

                                style:
                                    TextStyle(
                                  color: Colors
                                      .grey
                                      .shade500,

                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// STARS
                        Container(

                          padding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),

                          decoration:
                              BoxDecoration(

                            color:
                                getTransactionColor(
                                        type)
                                    .withOpacity(
                                        0.1),

                            borderRadius:
                                BorderRadius
                                    .circular(
                                        16),
                          ),

                          child: Text(

                            type == "earned"
                                ? "+$stars ⭐"
                                : "-$stars ⭐",

                            style: TextStyle(
                              fontWeight:
                                  FontWeight.bold,

                              color:
                                  getTransactionColor(
                                      type),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(height: 36),

              /// =========================
              /// RESERVAS
              /// =========================

              const Text(
                "Historial de Reservas",

                style: TextStyle(
                  fontSize: 22,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              ListView.builder(

                itemCount:
                    reservations.length,

                shrinkWrap: true,

                physics:
                    const NeverScrollableScrollPhysics(),

                itemBuilder:
                    (context, index) {

                  final reservation =
                      reservations[index];

                  final String status =
                      getReservationStatus(
                    reservation[
                        "check_out"],
                  );

                  return Container(

                    margin:
                        const EdgeInsets.only(
                            bottom: 18),

                    padding:
                        const EdgeInsets.all(
                            18),

                    decoration: BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                              24),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.05),

                          blurRadius: 10,

                          offset:
                              const Offset(
                                  0, 4),
                        ),
                      ],
                    ),

                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        /// TOP
                        Row(
                          children: [

                            /// ICONO
                            Container(

                              padding:
                                  const EdgeInsets
                                      .all(16),

                              decoration:
                                  BoxDecoration(

                                color:
                                    getReservationStatusColor(
                                            status)
                                        .withOpacity(
                                            0.15),

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            18),
                              ),

                              child: Icon(
                                Icons.hotel,

                                size: 34,

                                color:
                                    getReservationStatusColor(
                                        status),
                              ),
                            ),

                            const SizedBox(
                                width: 18),

                            /// INFO
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,

                                children: [

                                  Text(

                                    reservation[
                                        "hotel_name"],

                                    style:
                                        const TextStyle(
                                      fontSize:
                                          20,

                                      fontWeight:
                                          FontWeight
                                              .bold,
                                    ),
                                  ),

                                  const SizedBox(
                                      height:
                                          6),

                                  Text(
                                    reservation[
                                        "room_name"],

                                    style:
                                        TextStyle(
                                      color: Colors
                                          .grey
                                          .shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// STATUS
                            Container(

                              padding:
                                  const EdgeInsets
                                      .symmetric(
                                horizontal:
                                    14,
                                vertical:
                                    10,
                              ),

                              decoration:
                                  BoxDecoration(

                                color:
                                    getReservationStatusColor(
                                            status)
                                        .withOpacity(
                                            0.12),

                                borderRadius:
                                    BorderRadius
                                        .circular(
                                            16),
                              ),

                              child: Text(

                                formatStatus(
                                    status),

                                style:
                                    TextStyle(
                                  color:
                                      getReservationStatusColor(
                                          status),

                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                            height: 20),

                        /// FECHAS
                        Row(
                          children: [

                            Expanded(
                              child: Container(

                                padding:
                                    const EdgeInsets
                                        .all(
                                            14),

                                decoration:
                                    BoxDecoration(
                                  color:
                                      const Color(
                                          0xFFF8F6F1),

                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                              18),
                                ),

                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    const Text(
                                      "Check-in",

                                      style:
                                          TextStyle(
                                        color: Colors
                                            .grey,
                                      ),
                                    ),

                                    const SizedBox(
                                        height:
                                            6),

                                    Text(
                                      reservation[
                                          "check_in"],

                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(
                                width: 14),

                            Expanded(
                              child: Container(

                                padding:
                                    const EdgeInsets
                                        .all(
                                            14),

                                decoration:
                                    BoxDecoration(
                                  color:
                                      const Color(
                                          0xFFF8F6F1),

                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                              18),
                                ),

                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment
                                          .start,

                                  children: [

                                    const Text(
                                      "Check-out",

                                      style:
                                          TextStyle(
                                        color: Colors
                                            .grey,
                                      ),
                                    ),

                                    const SizedBox(
                                        height:
                                            6),

                                    Text(
                                      reservation[
                                          "check_out"],

                                      style:
                                          const TextStyle(
                                        fontWeight:
                                            FontWeight
                                                .bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(
                            height: 18),

                        /// TOTAL
                        Container(

                          padding:
                              const EdgeInsets
                                  .all(16),

                          decoration:
                              BoxDecoration(
                            color:
                                const Color(
                                    0xFFFFF8E1),

                            borderRadius:
                                BorderRadius
                                    .circular(
                                        18),
                          ),

                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceBetween,

                            children: [

                              const Text(
                                "Total Pagado",

                                style:
                                    TextStyle(
                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),

                              Text(

                                "S/ ${reservation["total_price"]}",

                                style:
                                    const TextStyle(
                                  fontSize: 18,

                                  fontWeight:
                                      FontWeight
                                          .bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}