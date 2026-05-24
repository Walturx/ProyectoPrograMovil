// lib/components/qr_reward/qr_reward_product_card.dart

import 'package:flutter/material.dart';

/// MODEL
import '../../models/reward_model.dart';

class QRRewardProductCard extends StatelessWidget {
  final RewardModel reward;

  final IconData icon;

  const QRRewardProductCard({
    super.key,

    required this.reward,

    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// TOP ICON
        Container(
          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: const Color(0xFFFFF3CD),

            borderRadius: BorderRadius.circular(24),
          ),

          child: Icon(icon, size: 50, color: const Color(0xFFD4AF37)),
        ),

        const SizedBox(height: 30),

        /// PRODUCT CARD
        Container(
          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(24),

            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
            ],
          ),

          child: Row(
            children: [
              /// ICON
              Container(
                padding: const EdgeInsets.all(14),

                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3CD),

                  borderRadius: BorderRadius.circular(18),
                ),

                child: Icon(icon, size: 34, color: const Color(0xFFD4AF37)),
              ),

              const SizedBox(width: 18),

              /// TEXTS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const Text(
                      "Premio Canjeado",

                      style: TextStyle(color: Colors.grey),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      reward.name,

                      style: const TextStyle(
                        fontSize: 20,

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 30),
      ],
    );
  }
}
