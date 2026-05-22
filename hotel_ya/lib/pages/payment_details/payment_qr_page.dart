import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaymentQRPage extends StatelessWidget {
  final String qrData;
  final int stars;

  PaymentQRPage({super.key, required this.qrData, required this.stars});

  @override
  Widget build(BuildContext context) {
    final hotelName = "XXX";
    final roomNumber = 103;
    final adults = 4;
    final children = 0;
    final user = "xxxxx";
    final checkIn = DateTime(2026, 1, 13, 15, 0);
    final checkOut = DateTime(2026, 1, 16, 14, 0);
    final pricePerNight = 150.0;
    final nights = checkOut.difference(checkIn).inDays;
    final total = nights * pricePerNight;
    final guests = [
      "Inv. 1: Nombre_completo",
      "Inv. 2: Nombre_completo",
      "Inv. 3: Nombre_completo",
    ];

    return Scaffold(
      body: Column(
        children: [
          Container(height: 60, color: const Color(0xFFDDBE5C)),

          // Contenido principal
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.lightBlue[200],
                    child: const Center(
                      child: Text(
                        "RESUMEN RESERVA",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text("Hotel: $hotelName"),
                  Text("Número de habitación: $roomNumber"),
                  Text("Adultos: $adults"),
                  Text("Infantes: $children"),
                  Text("Usuario: $user"),
                  Text(
                    "Check-in: ${checkIn.day}/${checkIn.month}/${checkIn.year} - ${checkIn.hour} pm",
                  ),
                  Text(
                    "Check-out: ${checkOut.day}/${checkOut.month}/${checkOut.year} - ${checkOut.hour} pm",
                  ),
                  Text(
                    "Precio por noche: \$${pricePerNight.toStringAsFixed(2)}",
                  ),
                  Text("Noches: $nights"),
                  Text("Total: \$${total.toStringAsFixed(2)}"),
                  const Divider(height: 20, thickness: 1),
                  const Text("INFORMACIÓN INVITADOS"),
                  ...guests.map((g) => Text(g)),
                  const SizedBox(height: 24),

                  // QR
                  Center(
                    child: QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 250,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Botón GUARDAR PAGO y estrellas
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            print("Pago guardado");
                            print("Estrellas ganadas: $stars");
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: const Color(0xFF6CB4EE),
                          ),
                          child: const Text("GUARDAR RESERVA"),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "⭐ Ganó $stars estrella${stars > 1 ? "s" : ""}",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        // Botón regresar al inicio
                        ElevatedButton.icon(
                          onPressed: () {
                            context.go('/home');
                          },
                          icon: const Icon(Icons.home),
                          label: const Text("Regresar al inicio"),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: const Color(0xFF6CB4EE),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Container(
            color: const Color(0xFFDDBE5C),
            height: 60,
            child: const Center(
              child: Icon(Icons.account_balance_wallet, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
