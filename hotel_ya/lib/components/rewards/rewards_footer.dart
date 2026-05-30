// lib/components/rewards/rewards_footer.dart

import 'package:flutter/material.dart';

class RewardsFooter extends StatelessWidget {
  final int selectedCost;

  final bool hasSelection;

  final VoidCallback onContinue;

  const RewardsFooter({
    super.key,

    required this.selectedCost,

    required this.hasSelection,

    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(24),

        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          /// TOTAL
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Total Gastado",

                style: TextStyle(color: Colors.grey.shade600),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Text(
                    "$selectedCost",

                    style: const TextStyle(
                      fontSize: 34,

                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(width: 8),

                  const Icon(Icons.star, color: Colors.amber, size: 30),
                ],
              ),
            ],
          ),

          /// BUTTON
          ElevatedButton.icon(
            onPressed: hasSelection ? onContinue : null,

            icon: const Icon(Icons.qr_code),

            label: const Text("Continuar"),

            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 18),

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
