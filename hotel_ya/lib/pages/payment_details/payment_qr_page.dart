import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:hotel_ya/components/wallet_bottom_nav.dart';

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
  State<PaymentQRPage> createState() =>
      _PaymentQRPageState();
}

class _PaymentQRPageState
    extends State<PaymentQRPage> {

  @override
  void initState() {

    super.initState();

    WidgetsBinding.instance
        .addPostFrameCallback((_) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          backgroundColor:
          Colors.green,

          behavior:
          SnackBarBehavior.floating,

          shape:
          RoundedRectangleBorder(

            borderRadius:
            BorderRadius.circular(14),
          ),

          content: Text(

            "⭐ Ganaste "
                "${widget.stars} estrellas",

            style: const TextStyle(

              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {

    final nights =
        widget.checkOut
            .difference(widget.checkIn)
            .inDays;

    final total =
        nights *
            widget.pricePerNight;

    return Scaffold(

      backgroundColor:
      const Color(0xFFF7F2EC),

      appBar: AppBar(

        backgroundColor:
        const Color(0xFFDDBE5C),

        elevation: 0,

        centerTitle: true,

        title: const Text(
          "QR Reserva",
        ),

        leading: IconButton(

          icon: const Icon(
            Icons.arrow_back,
          ),

          onPressed: () {
            context.pop();
          },
        ),
      ),

      bottomNavigationBar:
      const WalletBottomNav(),

      body: SafeArea(

        child: Padding(

          padding:
          const EdgeInsets.all(20),

          child: ListView(

            children: [

              Container(

                padding:
                const EdgeInsets.all(20),

                decoration: BoxDecoration(

                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(24),

                  boxShadow: [

                    BoxShadow(

                      color:
                      Colors.black.withOpacity(0.05),

                      blurRadius: 10,

                      offset:
                      const Offset(0, 4),
                    ),
                  ],
                ),

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Container(

                      width: double.infinity,

                      padding:
                      const EdgeInsets.all(14),

                      decoration: BoxDecoration(

                        color:
                        Colors.lightBlue[200],

                        borderRadius:
                        BorderRadius.circular(16),
                      ),

                      child: const Center(

                        child: Text(

                          "RESUMEN RESERVA",

                          style: TextStyle(

                            fontWeight:
                            FontWeight.bold,

                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      "Hotel: ${widget.hotelName}",
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Número habitación: ${widget.roomNumber}",
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Adultos: ${widget.adults}",
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Infantes: ${widget.children}",
                    ),

                    const SizedBox(height: 6),

                    Text(

                      "Check-in: "
                          "${widget.checkIn.day}/"
                          "${widget.checkIn.month}/"
                          "${widget.checkIn.year}",
                    ),

                    const SizedBox(height: 6),

                    Text(

                      "Check-out: "
                          "${widget.checkOut.day}/"
                          "${widget.checkOut.month}/"
                          "${widget.checkOut.year}",
                    ),

                    const SizedBox(height: 6),

                    Text(

                      "Precio por noche: "
                          "\$${widget.pricePerNight.toStringAsFixed(2)}",
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "Noches: $nights",
                    ),

                    const SizedBox(height: 6),

                    Text(

                      "Total: "
                          "\$${total.toStringAsFixed(2)}",
                    ),

                    const SizedBox(height: 20),

                    const Divider(),

                    const SizedBox(height: 12),

                    const Text(

                      "INFORMACIÓN INVITADOS",

                      style: TextStyle(

                        fontWeight:
                        FontWeight.bold,

                        fontSize: 16,
                      ),
                    ),

                    const SizedBox(height: 12),

                    ...widget.guests
                        .asMap()
                        .entries
                        .map((entry) {

                      final guest =
                          entry.value;

                      return Padding(

                        padding:
                        const EdgeInsets.only(
                          bottom: 8,
                        ),

                        child: Text(

                          "Inv. ${entry.key + 1}: "
                              "${guest['name']} "
                              "${guest['lastName']} "
                              "(${guest['age']} años)",
                        ),
                      );
                    }).toList(),

                    const SizedBox(height: 30),

                    Center(

                      child: QrImageView(

                        data:
                        widget.qrData,

                        version:
                        QrVersions.auto,

                        size: 250,
                      ),
                    ),

                    const SizedBox(height: 30),

                    SizedBox(

                      width: double.infinity,

                      child: ElevatedButton(

                        onPressed: () {

                          /// TODO:
                          /// Conectar StarsCubit
                          /// para sumar automáticamente
                          /// las estrellas del usuario.
                        },

                        style:
                        ElevatedButton.styleFrom(

                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 18,
                          ),

                          shape:
                          RoundedRectangleBorder(

                            borderRadius:
                            BorderRadius.circular(20),
                          ),

                          backgroundColor:
                          const Color(0xFF6CB4EE),
                        ),

                        child: const Text(

                          "GUARDAR RESERVA",

                          style: TextStyle(

                            fontWeight:
                            FontWeight.bold,

                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    SizedBox(

                      width: double.infinity,

                      child: ElevatedButton.icon(

                        onPressed: () {

                          context.go('/home');
                        },

                        icon: const Icon(
                          Icons.home,
                        ),

                        label: const Text(
                          "Regresar al inicio",
                        ),

                        style:
                        ElevatedButton.styleFrom(

                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 18,
                          ),

                          shape:
                          RoundedRectangleBorder(

                            borderRadius:
                            BorderRadius.circular(20),
                          ),

                          backgroundColor:
                          const Color(0xFF6CB4EE),
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