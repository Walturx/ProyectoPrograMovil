import 'package:flutter/material.dart';
import '../../services/reservation_qr_service.dart';
import '../payment/payment_page.dart';
import '../../components/wallet_bottom_nav.dart';

class ReservationDetailsPage extends StatelessWidget {
  final String hotelName;
  final int roomNumber;
  final String roomType;
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
    required this.roomType,
    required this.guests,
    required this.checkIn,
    required this.checkInHour,
    required this.checkOut,
    required this.checkOutHour,
    required this.pricePerNight,
  });

  @override
  Widget build(BuildContext context) {
    final nights   = checkOut.difference(checkIn).inDays;
    final adults   = guests.where((g) => g['age'] >= 18).length + 1;
    final children = guests.where((g) => g['age'] < 18).length;
    final total    = nights * pricePerNight;
    final stars    = (adults + children) + 3;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDDBE5C),
        centerTitle: true,
        title: const Text("Resumen Reserva"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      bottomNavigationBar: const WalletBottomNav(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _InfoCard(children: [
              _SectionHeader("RESUMEN RESERVA"),
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
            ]),
            const SizedBox(height: 16),
            _InfoCard(children: [
              const Text("INFORMACIÓN INVITADOS", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...guests.asMap().entries.map(
                    (e) => Text("Inv. ${e.key + 1}: ${e.value['name']} ${e.value['lastName'] ?? ''} (${e.value['age']} años)"),
              ),
            ]),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final qrData = ReservationQRService().generateReservationQR(
                    hotelName:   hotelName,
                    roomType:    roomType, // FALTA CAMBIAR EL TIPO DE CUARTO
                    roomNumber:  roomNumber,
                    checkIn:     checkIn,
                    checkOut:    checkOut,
                    totalGuests: adults + children,
                    totalPrice:  total,
                    guests:      guests,
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentPage(
                        qrData:        qrData,
                        stars:         stars,
                        hotelName:     hotelName,
                        roomNumber:    roomNumber,
                        adults:        adults,
                        children:      children,
                        checkIn:       checkIn,
                        checkOut:      checkOut,
                        pricePerNight: pricePerNight,
                        guests:        guests,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  backgroundColor: Colors.lightBlue[200],
                ),
                child: const Text("REALIZAR PAGO"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: Colors.lightBlue[200], borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      ),
    );
  }
}