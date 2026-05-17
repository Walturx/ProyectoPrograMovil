// lib/components/history/transaction_card.dart

import 'package:flutter/material.dart';

/// MODEL
import '../../models/loyalty_transaction_model.dart';

/// CONTROLLER
import '../../pages/history/history_controller.dart';

class TransactionCard
    extends StatelessWidget {

  final LoyaltyTransactionModel
      transaction;

  final HistoryController
      controller;

  const TransactionCard({

    super.key,

    required this.transaction,

    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    final String type =
        transaction.type;

    final int stars =
        transaction.stars;

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

      child: Row(
        children: [

          /// ICON
          Container(

            padding:
                const EdgeInsets
                    .all(16),

            decoration:
                BoxDecoration(

              color: controller
                  .getTransactionColor(
                      type)
                  .withOpacity(
                      0.15),

              borderRadius:
                  BorderRadius
                      .circular(
                          18),
            ),

            child: Icon(

              controller
                  .getTransactionIcon(
                      type),

              size: 34,

              color: controller
                  .getTransactionColor(
                      type),
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

                  transaction
                      .description,

                  style:
                      const TextStyle(

                    fontSize:
                        18,

                    fontWeight:
                        FontWeight
                            .bold,
                  ),
                ),

                const SizedBox(
                    height: 10),

                Text(

                  transaction
                      .createdAt
                      .toString(),

                  style:
                      TextStyle(

                    color: Colors
                        .grey
                        .shade500,

                    fontSize:
                        13,
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

              color: controller
                  .getTransactionColor(
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
                    FontWeight
                        .bold,

                color: controller
                    .getTransactionColor(
                        type),
              ),
            ),
          ),
        ],
      ),
    );
  }
}