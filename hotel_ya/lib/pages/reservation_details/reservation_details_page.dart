import 'package:flutter/material.dart';
import '../../services/reservation_qr_service.dart';
import '../payment/payment_page.dart';
import '../../components/wallet_bottom_nav.dart';
class ReservationDetailsPage extends StatelessWidget {
  final String hotelName;
  final int roomNumber;
  final List<Map<String, dynamic>> guests;
  final DateTime checkIn;
  final int checkInHour;
  final DateTime checkOut;
  final int checkOutHour;
  final double pricePerNight;

  const ReservationDetailsPage({
    super.key,
    required this.hotelName,
    required this.roomNumber,
    required this.guests,
    required this.checkIn,
    required this.checkInHour,
    required this.checkOut,
    required this.checkOutHour,
    required this.pricePerNight,
  });

  @override
  Widget build(BuildContext context) {
    // Calcular número de noches
    final nights = checkOut.difference(checkIn).inDays;

    // Calcular adultos e infantes
    final adults = guests.where((g) => g['age'] >= 18).length+1;
    final children = guests.where((g) => g['age'] < 18).length;

    // Precio total
    final total = nights * pricePerNight;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDDBE5C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Resumen Reserva"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // Resumen de reserva en cuadro blanco
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.lightBlue[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "RESUMEN RESERVA",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text("Hotel: $hotelName"),
                  Text("Número de habitación: $roomNumber"),
                  Text("Adultos: $adults"),
                  Text("Infantes: $children"),
                  Text("Check-in: ${checkIn.day}/${checkIn.month}/${checkIn.year} - $checkInHour:00"),
                  Text("Check-out: ${checkOut.day}/${checkOut.month}/${checkOut.year} - $checkOutHour:00"),
                  Text("Precio por noche: \$${pricePerNight.toStringAsFixed(2)}"),
                  Text("Noches: $nights"),
                  Text("Total: \$${total.toStringAsFixed(2)}"),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Información invitados en cuadro blanco
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "INFORMACIÓN INVITADOS",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...guests.asMap().entries.map((entry) {
                    final g = entry.value;
                    return Text("Inv. ${entry.key + 1}: ${g['name']} (${g['age']} años)");
                  }).toList(),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Botón Realizar Pago
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {

                  final qrService = ReservationQRService();

                  final qrData = qrService.generateReservationQR(
                    hotelName: hotelName,
                    roomType: "Suite",
                    roomNumber: roomNumber,
                    checkIn: checkIn,
                    checkOut: checkOut,
                    totalGuests: adults + children,
                    totalPrice: total,
                    guests: guests,
                  );

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) => PaymentPage(

                        qrData: qrData,

                        stars: (adults + children) + 3,

                        hotelName: hotelName,

                        roomNumber: roomNumber,

                        adults: adults,

                        children: children,

                        checkIn: checkIn,

                        checkOut: checkOut,

                        pricePerNight:
                        pricePerNight,

                        guests: guests,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.lightBlue[200],
                ),
                child: const Text("REALIZAR PAGO"),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar:
      const WalletBottomNav(),
    );
  }
}