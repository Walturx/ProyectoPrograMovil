// lib/components/qr_reward/qr_reward_header.dart

import 'package:flutter/material.dart';

class QRRewardHeader
    extends StatelessWidget {

  const QRRewardHeader({
    super.key,
  });

  @override
  Widget build(
      BuildContext context) {

    return Column(

      children: [

        const SizedBox(
            height: 20),

        /// TITULO
        const Text(

          "Canje Realizado",

          textAlign:
              TextAlign.center,

          style: TextStyle(
            fontSize: 30,
            fontWeight:
                FontWeight.bold,
          ),
        ),

        const SizedBox(
            height: 10),

        Text(

          "Presenta este código QR\npara reclamar tu premio",

          textAlign:
              TextAlign.center,

          style: TextStyle(
            fontSize: 16,
            color:
                Colors.grey.shade600,
          ),
        ),

        const SizedBox(
            height: 30),
      ],
    );
  }
}