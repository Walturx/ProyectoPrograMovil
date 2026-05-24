// lib/components/history/reservation_card.dart

import 'package:flutter/material.dart';

/// MODEL
import '../../models/reservation_model.dart';

class ReservationCard extends StatelessWidget {
  final ReservationModel reservation;

  final String hotelName;

  final String roomTypeName;

  final String status;

  final Color statusColor;

  final String formattedStatus;

  const ReservationCard({
    super.key,

    required this.reservation,

    required this.hotelName,

    required this.roomTypeName,

    required this.status,

    required this.statusColor,

    required this.formattedStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),

            blurRadius: 10,

            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          /// TOP
          Row(
            children: [
              /// ICON
              Container(
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.15),

                  borderRadius: BorderRadius.circular(18),
                ),

                child: Icon(Icons.hotel, size: 34, color: statusColor),
              ),

              const SizedBox(width: 18),

              /// INFO
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    /// HOTEL NAME
                    Text(
                      hotelName,

                      style: const TextStyle(
                        fontSize: 20,

                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// ROOM TYPE
                    Text(
                      roomTypeName,

                      style: TextStyle(
                        color: Colors.grey.shade700,

                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              /// STATUS
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),

                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.12),

                  borderRadius: BorderRadius.circular(16),
                ),

                child: Text(
                  formattedStatus,

                  style: TextStyle(
                    color: statusColor,

                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// GUESTS
          Row(
            children: [
              const Icon(Icons.people, size: 20),

              const SizedBox(width: 8),

              Text(
                "${reservation.adults} adultos · ${reservation.children} niños",
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// DATES
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),

                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F6F1),

                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Check-in",

                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        reservation.checkIn.toString(),

                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(14),

                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F6F1),

                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const Text(
                        "Check-out",

                        style: TextStyle(color: Colors.grey),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        reservation.checkOut.toString(),

                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          if (reservation.specialRequests.isNotEmpty) ...[
            const SizedBox(height: 18),

            Container(
              width: double.infinity,

              padding: const EdgeInsets.all(14),

              decoration: BoxDecoration(
                color: const Color(0xFFF8F6F1),

                borderRadius: BorderRadius.circular(18),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Solicitudes Especiales",

                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  Text(reservation.specialRequests),
                ],
              ),
            ),
          ],

          const SizedBox(height: 18),

          /// TOTAL
          Container(
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),

              borderRadius: BorderRadius.circular(18),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                const Text(
                  "Total Pagado",

                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(
                  "S/ ${reservation.totalPrice}",

                  style: const TextStyle(
                    fontSize: 18,

                    fontWeight: FontWeight.bold,
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
