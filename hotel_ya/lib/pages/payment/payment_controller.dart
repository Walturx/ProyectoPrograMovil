import 'package:get/get.dart';

class PaymentController extends GetxController {
  // Campos del formulario como variables reactivas
  RxString country = ''.obs;
  RxString email = ''.obs;
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString cardNumber = ''.obs;
  RxString cvv = ''.obs;
  RxString expiryDate = ''.obs;

  // Validar si todos los campos tienen datos
  bool get isFormValid =>
      country.isNotEmpty &&
          email.isNotEmpty &&
          firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          cardNumber.isNotEmpty &&
          cvv.isNotEmpty &&
          expiryDate.isNotEmpty;

  // Función para enviar el pago (simulada)
  void submitPayment() {
    if (!isFormValid) {
      print("Faltan campos por llenar");
      return;
    }

    // Aquí iría tu POST al backend
    print("Enviando pago:");
    print("País: ${country.value}");
    print("Email: ${email.value}");
    print("Nombre: ${firstName.value} ${lastName.value}");
    print("Tarjeta: ${cardNumber.value}");
    print("CVV: ${cvv.value}");
    print("Expira: ${expiryDate.value}");
  }
}