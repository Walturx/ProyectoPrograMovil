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
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late final PaymentController control;

  @override
  void initState() {
    super.initState();
    control = Get.put(PaymentController(), tag: UniqueKey().toString());
    control.clearData();
  }

  @override
  void dispose() {
    Get.delete<PaymentController>();
    super.dispose();
  }

  // ─── Decoración reutilizable ───────────────────────────────────────────────

  InputDecoration _inputDeco({required String label, required IconData icon, String? hint}) =>
      InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFD4AF37), width: 2),
        ),
      );

  // ─── Navegación ───────────────────────────────────────────────────────────

  void _onContinue() {
    if (!control.validatePayment()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Complete correctamente los datos de pago'),
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

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDDBE5C),
        elevation: 0,
        centerTitle: true,
        title: const Text("Método de pago"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: context.pop,
        ),
      ),
      bottomNavigationBar: const WalletBottomNav(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              _FormCard(
                children: [
                  _SectionHeader("INGRESE INFORMACIÓN DE SU TARJETA"),
                  const SizedBox(height: 24),
                  _PaymentField(
                    deco: _inputDeco(label: "País", icon: Icons.public),
                    keyboardType: TextInputType.name,
                    formatters: [_lettersOnly],
                    onChanged: (v) => control.country.value = v,
                  ),
                  const SizedBox(height: 18),
                  _PaymentField(
                    deco: _inputDeco(label: "Correo electrónico", icon: Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (v) => control.email.value = v,
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _PaymentField(
                          deco: _inputDeco(label: "Nombre", icon: Icons.person_outline),
                          keyboardType: TextInputType.name,
                          formatters: [_lettersOnly],
                          onChanged: (v) => control.firstName.value = v,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _PaymentField(
                          deco: _inputDeco(label: "Apellidos", icon: Icons.badge_outlined),
                          keyboardType: TextInputType.name,
                          formatters: [_lettersOnly],
                          onChanged: (v) => control.lastName.value = v,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _PaymentField(
                    deco: _inputDeco(label: "Número de tarjeta", icon: Icons.credit_card),
                    keyboardType: TextInputType.number,
                    maxLength: 16,
                    formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(16)],
                    onChanged: (v) {
                      control.cardNumber.value = v;
                      control.detectCardType(v);
                    },
                  ),
                  Obx(() => control.cardType.value.isEmpty
                      ? const SizedBox()
                      : Padding(
                    padding: const EdgeInsets.only(top: 8),
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
                  )),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: _PaymentField(
                          deco: _inputDeco(label: "CVV", icon: Icons.lock_outline),
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          formatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
                          onChanged: (v) => control.cvv.value = v,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: _ExpiryPicker(control: control)),
                    ],
                  ),
                  const SizedBox(height: 28),
                  _ContinueButton(onPressed: _onContinue),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Formatter reutilizable ───────────────────────────────────────────────────

final _lettersOnly = FilteringTextInputFormatter.allow(
  RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]'),
);

// ─── Widgets privados ─────────────────────────────────────────────────────────

class _FormCard extends StatelessWidget {
  final List<Widget> children;
  const _FormCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(children: children),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.lightBlue[200],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }
}

class _PaymentField extends StatelessWidget {
  final InputDecoration deco;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? formatters;
  final ValueChanged<String> onChanged;
  final int? maxLength;

  const _PaymentField({
    required this.deco,
    required this.onChanged,
    this.keyboardType,
    this.formatters,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: deco,
      keyboardType: keyboardType,
      maxLength: maxLength,
      inputFormatters: formatters,
      onChanged: onChanged,
    );
  }
}

class _ExpiryPicker extends StatelessWidget {
  final PaymentController control;
  const _ExpiryPicker({required this.control});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2035),
          helpText: 'Seleccionar fecha de vencimiento',
        );
        if (picked != null) {
          control.expiryDate.value =
          '${picked.month.toString().padLeft(2, '0')}/${picked.year.toString().substring(2)}';
        }
      },
      child: Obx(() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                control.expiryDate.value.isEmpty ? 'Fecha vencimiento' : control.expiryDate.value,
                style: TextStyle(
                  color: control.expiryDate.value.isEmpty ? Colors.grey : Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class _ContinueButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _ContinueButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6CB4EE),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        child: const Text(
          "CONTINUAR",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}