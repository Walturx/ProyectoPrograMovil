import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../payment_details/payment_qr_page.dart';
import 'payment_controller.dart';

class PaymentPage extends StatelessWidget {
  final PaymentController control = Get.put(PaymentController());
  final String qrData;
  final int stars;

  PaymentPage({super.key, required this.qrData, required this.stars});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFDDBE5C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.lightBlue[200],
              child: const Center(
                child: Text(
                  "INGRESE INFORMACIÓN DE SU TARJETA",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // País
            TextFormField(
              decoration: const InputDecoration(labelText: "País"),
              onChanged: (val) => control.country.value = val,
            ),
            const SizedBox(height: 16),
            // Correo electrónico
            TextFormField(
              decoration: const InputDecoration(labelText: "Correo electrónico"),
              onChanged: (val) => control.email.value = val,
            ),
            const SizedBox(height: 16),
            // Nombre y Apellidos
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Nombre"),
                    onChanged: (val) => control.firstName.value = val,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Apellidos"),
                    onChanged: (val) => control.lastName.value = val,
                  ),
                ),

              ],
            ),
            const SizedBox(height: 16),
            // Número de tarjeta
            TextFormField(
              decoration: const InputDecoration(labelText: "Número de tarjeta"),
              onChanged: (val) => control.cardNumber.value = val,
            ),
            const SizedBox(height: 16),
            // Código de seguridad y fecha de caducidad
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Código de seguridad"),
                    onChanged: (val) => control.cvv.value = val,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(labelText: "Fecha de caducidad"),
                    onChanged: (val) => control.expiryDate.value = val,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Botón CONTINUAR
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  control.submitPayment();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PaymentQRPage(
                        qrData: qrData,
                        stars: stars,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.payment),
                label: const Text("CONTINUAR"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue[200],
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Footer fijo con la billetera
      bottomNavigationBar: Container(
        color: const Color(0xFFDDBE5C),
        height: 60,
        child: const Center(
          child: Icon(Icons.account_balance_wallet, size: 30),
        ),
      ),
    );
  }
}