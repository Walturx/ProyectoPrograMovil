import 'package:flutter/material.dart';

class WalletBottomNav extends StatelessWidget {
  const WalletBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFFFE082),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Icon(
            Icons.account_balance_wallet,
            size: 30,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}