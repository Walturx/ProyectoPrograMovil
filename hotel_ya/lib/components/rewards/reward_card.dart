// lib/components/rewards/reward_card.dart

import 'package:flutter/material.dart';

/// MODEL
import '../../models/reward_model.dart';

class RewardCard extends StatelessWidget {
  final RewardModel reward;

  final bool isSelected;

  final bool canAfford;

  final IconData icon;

  final VoidCallback? onTap;

  const RewardCard({
    super.key,

    required this.reward,

    required this.isSelected,

    required this.canAfford,

    required this.icon,

    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: canAfford ? onTap : null,

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),

        margin: const EdgeInsets.only(bottom: 20),

        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(26),

          border: Border.all(
            color: isSelected ? const Color(0xFFD4AF37) : Colors.transparent,

            width: 2.5,
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),

              blurRadius: 10,

              offset: const Offset(0, 4),
            ),
          ],
        ),

        child: Row(
          children: [
            /// ICON
            Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: const Color(0xFFFFF3CD),

                borderRadius: BorderRadius.circular(18),
              ),

              child: Icon(icon, size: 34, color: const Color(0xFFD4AF37)),
            ),

            const SizedBox(width: 18),

            /// INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    reward.name,

                    style: const TextStyle(
                      fontSize: 24,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    reward.description,

                    style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 22),

                      const SizedBox(width: 6),

                      Text(
                        "${reward.starsCost} estrellas",

                        style: const TextStyle(
                          fontSize: 16,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            /// CHECK
            if (isSelected)
              const Icon(
                Icons.check_circle,

                color: Color(0xFFD4AF37),

                size: 34,
              ),
          ],
        ),
      ),
    );
  }
}
