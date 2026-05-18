// lib/components/history/reservation_card.dart

import 'package:flutter/material.dart';

/// MODEL
import '../../models/reservation_model.dart';

/// CONTROLLER
import '../../pages/history/history_controller.dart';

class ReservationCard
    extends StatelessWidget {

  final ReservationModel
      reservation;

  final HistoryController
      controller;

  const ReservationCard({

    super.key,

    required this.reservation,

    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    final String status =
        controller
            .getReservationStatus(
      reservation.checkOut,
    );

    return Container(

      margin:
          const EdgeInsets.only(
        bottom: 18,
      ),

      padding:
          const EdgeInsets.all(
        18,
      ),

      decoration:
          BoxDecoration(

        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
                24),

        boxShadow: [

          BoxShadow(

            color: Colors.black
                .withOpacity(
                    0.05),

            blurRadius: 10,

            offset:
                const Offset(
              0,
              4,
            ),
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

              /// ICON
              Container(

                padding:
                    const EdgeInsets
                        .all(16),

                decoration:
                    BoxDecoration(

                  color: controller
                      .getReservationStatusColor(
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

                  color: controller
                      .getReservationStatusColor(
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

                      reservation
                          .roomId,

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
                        height: 6),

                    Text(

                      reservation
                          .status,

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
                  horizontal: 14,
                  vertical: 10,
                ),

                decoration:
                    BoxDecoration(

                  color: controller
                      .getReservationStatusColor(
                          status)
                      .withOpacity(
                          0.12),

                  borderRadius:
                      BorderRadius
                          .circular(
                              16),
                ),

                child: Text(

                  controller
                      .formatStatus(
                          status),

                  style:
                      TextStyle(

                    color: controller
                        .getReservationStatusColor(
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

          /// DATES
          Row(
            children: [

              Expanded(

                child: Container(

                  padding:
                      const EdgeInsets
                          .all(14),

                  decoration:
                      BoxDecoration(

                    color:
                        const Color(
                      0xFFF8F6F1,
                    ),

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

                        style: TextStyle(
                          color:
                              Colors.grey,
                        ),
                      ),

                      const SizedBox(
                          height: 6),

                      Text(

                        reservation
                            .checkIn
                            .toString(),

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
                          .all(14),

                  decoration:
                      BoxDecoration(

                    color:
                        const Color(
                      0xFFF8F6F1,
                    ),

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

                        style: TextStyle(
                          color:
                              Colors.grey,
                        ),
                      ),

                      const SizedBox(
                          height: 6),

                      Text(

                        reservation
                            .checkOut
                            .toString(),

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
                0xFFFFF8E1,
              ),

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

                  "S/ ${reservation.totalPrice}",

                  style:
                      const TextStyle(

                    fontSize:
                        18,

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
  }
}