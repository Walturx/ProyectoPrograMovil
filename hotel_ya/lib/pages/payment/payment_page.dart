import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import 'package:hotel_ya/components/wallet_bottom_nav.dart';

import '../payment_details/payment_qr_page.dart';
import 'payment_controller.dart';

class PaymentPage extends StatefulWidget {

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

  const PaymentPage({

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
  State<PaymentPage> createState() =>
      _PaymentPageState();
}

class _PaymentPageState
    extends State<PaymentPage> {

  late final PaymentController control;

  @override
  void initState() {
    super.initState();

    control = Get.put(
      PaymentController(),
      tag: UniqueKey().toString(),
    );

    control.clearData();
  }

  @override
  void dispose() {
    Get.delete<PaymentController>();
    super.dispose();
  }

  InputDecoration customInput({

    required String label,
    required IconData icon,
    String? hint,

  }) {

    return InputDecoration(

      labelText: label,
      hintText: hint,

      prefixIcon: Icon(icon),

      filled: true,
      fillColor: Colors.grey.shade50,

      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(16),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(16),

        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(16),

        borderSide: const BorderSide(
          color: Color(0xFFD4AF37),
          width: 2,
        ),
      ),
    );
  }

  void continuePayment() {

    final isValid =
    control.validatePayment();

    if (!isValid) {

      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content: Text(
            'Complete correctamente los datos de pago',
          ),

          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (_) => PaymentQRPage(

          qrData: widget.qrData,
          stars: widget.stars,
          hotelName: widget.hotelName,
          roomNumber: widget.roomNumber,
          adults: widget.adults,
          children: widget.children,
          checkIn: widget.checkIn,
          checkOut: widget.checkOut,
          pricePerNight: widget.pricePerNight,
          guests: widget.guests,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFFF7F2EC),

      appBar: AppBar(

        backgroundColor:
        const Color(0xFFDDBE5C),

        elevation: 0,

        centerTitle: true,

        title: const Text(
          "Método de pago",
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

          padding: const EdgeInsets.all(20),

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

                          "INGRESE INFORMACIÓN DE SU TARJETA",

                          textAlign: TextAlign.center,

                          style: TextStyle(

                            fontWeight:
                            FontWeight.bold,

                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    TextFormField(

                      decoration: customInput(

                        label: "País",
                        icon: Icons.public,
                      ),

                      keyboardType:
                      TextInputType.name,

                      inputFormatters: [

                        FilteringTextInputFormatter.allow(

                          RegExp(
                            r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]',
                          ),
                        ),
                      ],

                      onChanged: (val) =>
                      control.country.value = val,
                    ),

                    const SizedBox(height: 18),

                    TextFormField(

                      decoration: customInput(

                        label:
                        "Correo electrónico",

                        icon:
                        Icons.email_outlined,
                      ),

                      keyboardType:
                      TextInputType.emailAddress,

                      onChanged: (val) =>
                      control.email.value = val,
                    ),

                    const SizedBox(height: 18),

                    Row(

                      children: [

                        Expanded(

                          child: TextFormField(

                            decoration: customInput(

                              label: "Nombre",

                              icon:
                              Icons.person_outline,
                            ),

                            keyboardType:
                            TextInputType.name,

                            inputFormatters: [

                              FilteringTextInputFormatter.allow(

                                RegExp(
                                  r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]',
                                ),
                              ),
                            ],

                            onChanged: (val) =>
                            control.firstName.value = val,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(

                          child: TextFormField(

                            decoration: customInput(

                              label: "Apellidos",

                              icon:
                              Icons.badge_outlined,
                            ),

                            keyboardType:
                            TextInputType.name,

                            inputFormatters: [

                              FilteringTextInputFormatter.allow(

                                RegExp(
                                  r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]',
                                ),
                              ),
                            ],

                            onChanged: (val) =>
                            control.lastName.value = val,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    TextFormField(

                      decoration: customInput(

                        label:
                        "Número de tarjeta",

                        icon:
                        Icons.credit_card,
                      ),

                      keyboardType:
                      TextInputType.number,

                      maxLength: 16,

                      inputFormatters: [

                        FilteringTextInputFormatter
                            .digitsOnly,

                        LengthLimitingTextInputFormatter(
                          16,
                        ),
                      ],

                      onChanged: (val) {

                        control.cardNumber.value = val;
                        control.detectCardType(val);
                      },
                    ),
                    Obx(() {
                      if (control.cardType.value.isEmpty) {
                        return const SizedBox();
                      }
                      return Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "💳 ${control.cardType.value}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: customInput(
                              label: "CVV",
                              icon:
                              Icons.lock_outline,
                            ),
                            keyboardType:
                            TextInputType.number,

                            maxLength: 3,

                            inputFormatters: [

                              FilteringTextInputFormatter
                                  .digitsOnly,

                              LengthLimitingTextInputFormatter(
                                3,
                              ),
                            ],

                            onChanged: (val) =>
                            control.cvv.value = val,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(

                          child: InkWell(

                            onTap: () async {

                              final pickedDate =
                              await showDatePicker(

                                context: context,

                                initialDate: DateTime.now(),

                                firstDate: DateTime.now(),

                                lastDate: DateTime(2035),

                                helpText:
                                'Seleccionar fecha de vencimiento',
                              );

                              if (pickedDate != null) {

                                final formattedDate =

                                    '${pickedDate.month.toString().padLeft(2, '0')}/'
                                    '${pickedDate.year.toString().substring(2)}';

                                control.expiryDate.value =
                                    formattedDate;
                              }
                            },

                            child: Obx(() {

                              return Container(

                                padding:
                                const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 18,
                                ),

                                decoration: BoxDecoration(

                                  color: Colors.grey.shade50,

                                  borderRadius:
                                  BorderRadius.circular(16),

                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),

                                child: Row(

                                  children: [

                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.grey,
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(

                                      child: Text(

                                        control.expiryDate.value.isEmpty

                                            ? 'Fecha vencimiento'

                                            : control.expiryDate.value,

                                        style: TextStyle(

                                          color:
                                          control.expiryDate.value.isEmpty

                                              ? Colors.grey

                                              : Colors.black,

                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    SizedBox(

                      width: double.infinity,

                      child: ElevatedButton(

                        onPressed: continuePayment,

                        style: ElevatedButton.styleFrom(

                          backgroundColor:
                          const Color(0xFF6CB4EE),

                          elevation: 0,

                          padding:
                          const EdgeInsets.symmetric(
                            vertical: 18,
                          ),

                          shape:
                          RoundedRectangleBorder(

                            borderRadius:
                            BorderRadius.circular(20),
                          ),
                        ),

                        child: const Text(

                          "CONTINUAR",

                          style: TextStyle(

                            fontSize: 17,

                            fontWeight:
                            FontWeight.bold,
                          ),
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