// lib/components/qr_reward/qr_reward_qr_card.dart

import 'package:flutter/material.dart';

class QRRewardQRCard extends StatelessWidget {
  final String qrData;

  final int remainingStars;

  const QRRewardQRCard({
    super.key,

    required this.qrData,

    required this.remainingStars,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(24),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(30),

        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),

      child: Column(
        children: [
          /// QR
          Container(
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: const Color(0xFFF8F6F1),

              borderRadius: BorderRadius.circular(24),
            ),

            child: Image.network(
              "https://quickchart.io/qr"
              "?size=250"
              "&text=$qrData",

              width: 220,

              height: 220,

              errorBuilder: (_, __, ___) {
                return const SizedBox(
                  width: 220,

                  height: 220,

                  child: Center(child: Text("QR Error")),
                );
              },
            ),
          ),

          const SizedBox(height: 30),

          /// STARS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),

            decoration: BoxDecoration(
              color: const Color(0xFFFFF8E1),

              borderRadius: BorderRadius.circular(20),
            ),

            child: Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                Text(
                  "$remainingStars",

                  style: const TextStyle(
                    fontSize: 32,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(width: 10),

                const Icon(Icons.star, color: Colors.amber, size: 34),

                const SizedBox(width: 10),

                Text(
                  "restantes",

                  style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
