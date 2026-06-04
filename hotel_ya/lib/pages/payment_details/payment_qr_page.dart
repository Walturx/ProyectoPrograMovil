// lib/pages/payment_details/payment_qr_page.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:hotel_ya/components/wallet_bottom_nav.dart';
import 'payment_qr_controller.dart';

class PaymentQRPage extends StatefulWidget {
  final String qrData;
  final int stars;
  final String hotelName;
  final int roomNumber;
  final int adults;
  final int children;
  final DateTime checkIn;
  final DateTime checkOut;
  final double pricePerNight;
  final List<Map<String, dynamic>> guests;

  const PaymentQRPage({
    super.key,
    required this.qrData,
    required this.stars,
    required this.hotelName,
    required this.roomNumber,
    required this.adults,
    required this.children,
    required this.checkIn,
    required this.checkOut,
    required this.pricePerNight,
    required this.guests,
  });

  @override
  State<PaymentQRPage> createState() => _PaymentQRPageState();
}

class _PaymentQRPageState extends State<PaymentQRPage> {
  late final PaymentQRController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = Get.put(PaymentQRController());

    _ctrl.callAddStars(widget.stars);

    // Snackbar de estrellas — se dispara una sola vez
    _ctrl.isLoading.listen((loading) {
      if (!loading && !_ctrl.snackbarShown) {
        _ctrl.snackbarShown = true;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          content: Text(
            "⭐ Ganaste ${_ctrl.starsAwarded.value} estrellas",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final nights = widget.checkOut.difference(widget.checkIn).inDays;
    final total  = nights * widget.pricePerNight;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDDBE5C),
        elevation: 0,
        centerTitle: true,
        title: const Text("QR Reserva"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      bottomNavigationBar: const WalletBottomNav(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
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

                    // ── Header ───────────────────────────────────────────
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          "RESUMEN RESERVA",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ── Datos de reserva ──────────────────────────────────
                    Text("Hotel: ${widget.hotelName}"),
                    const SizedBox(height: 6),
                    Text("Número habitación: ${widget.roomNumber}"),
                    const SizedBox(height: 6),
                    Text("Adultos: ${widget.adults}"),
                    const SizedBox(height: 6),
                    Text("Infantes: ${widget.children}"),
                    const SizedBox(height: 6),
                    Text("Check-in: ${widget.checkIn.day}/${widget.checkIn.month}/${widget.checkIn.year}"),
                    const SizedBox(height: 6),
                    Text("Check-out: ${widget.checkOut.day}/${widget.checkOut.month}/${widget.checkOut.year}"),
                    const SizedBox(height: 6),
                    Text("Precio por noche: \$${widget.pricePerNight.toStringAsFixed(2)}"),
                    const SizedBox(height: 6),
                    Text("Noches: $nights"),
                    const SizedBox(height: 6),
                    Text("Total: \$${total.toStringAsFixed(2)}"),

                    const SizedBox(height: 12),

                    // ── Badge estrellas ───────────────────────────────────
                    Obx(() => Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF8E1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFDDBE5C)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Color(0xFFDDBE5C), size: 20),
                          const SizedBox(width: 8),
                          _ctrl.isLoading.value
                              ? const SizedBox(
                            width: 16, height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                              : Text(
                            "Estrellas totales: ${_ctrl.totalStars.value}  (+${_ctrl.starsAwarded.value})",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7A6000),
                            ),
                          ),
                        ],
                      ),
                    )),

                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 12),

                    // ── Invitados ─────────────────────────────────────────
                    const Text(
                      "INFORMACIÓN INVITADOS",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    ...widget.guests.asMap().entries.map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        "Inv. ${e.key + 1}: ${e.value['name']} ${e.value['lastName'] ?? ''} (${e.value['age']} años)",
                      ),
                    )),

                    const SizedBox(height: 30),

                    // ── QR ────────────────────────────────────────────────
                    Center(
                      child: QrImageView(
                        data: widget.qrData,
                        version: QrVersions.auto,
                        size: 250,
                      ),
                    ),

                    const SizedBox(height: 30),

                    // ── Botón GUARDAR RESERVA (genera PDF) ────────────────
                    Obx(() => SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _ctrl.isSavingPdf.value
                            ? null
                            : () => _ctrl.savePdf(
                          hotelName:     widget.hotelName,
                          roomNumber:    widget.roomNumber,
                          adults:        widget.adults,
                          children:      widget.children,
                          checkIn:       widget.checkIn,
                          checkOut:      widget.checkOut,
                          pricePerNight: widget.pricePerNight,
                          guests:        widget.guests,
                        ),
                        icon: _ctrl.isSavingPdf.value
                            ? const SizedBox(
                          width: 18, height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : const Icon(Icons.picture_as_pdf),
                        label: Text(
                          _ctrl.isSavingPdf.value ? "Guardando..." : "GUARDAR RESERVA",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          backgroundColor: const Color(0xFF6CB4EE),
                        ),
                      ),
                    )),

                    const SizedBox(height: 16),

                    // ── Botón HOME ────────────────────────────────────────
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => context.go('/home'),
                        icon: const Icon(Icons.home),
                        label: const Text("Regresar al inicio"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          backgroundColor: const Color(0xFF6CB4EE),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}