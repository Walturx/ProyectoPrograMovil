import 'package:get/get.dart';

class PaymentController extends GetxController {

  RxString country = ''.obs;
  RxString email = ''.obs;

  RxString firstName = ''.obs;
  RxString lastName = ''.obs;

  RxString cardNumber = ''.obs;
  RxString cardType = ''.obs;
  RxString cvv = ''.obs;
  RxString expiryDate = ''.obs;

  bool validatePayment() {

    if (
    country.value.trim().isEmpty ||
        email.value.trim().isEmpty ||
        firstName.value.trim().isEmpty ||
        lastName.value.trim().isEmpty ||
        cardNumber.value.trim().isEmpty ||
        cvv.value.trim().isEmpty ||
        expiryDate.value.trim().isEmpty
    ) {
      return false;
    }

    if (!email.value.contains('@')) {
      return false;
    }

    if (cardNumber.value.length != 16) {
      return false;
    }

    if (cvv.value.length != 3) {
      return false;
    }

    if (expiryDate.value.length != 5) {
      return false;
    }

    return true;
  }

  void detectCardType(String value) {

    if (value.startsWith('4')) {

      cardType.value = 'VISA';

    } else if (

    value.startsWith('5') ||
        value.startsWith('2')

    ) {

      cardType.value = 'MASTERCARD';

    } else if (

    value.startsWith('34') ||
        value.startsWith('37')

    ) {

      cardType.value = 'AMEX';

    } else {

      cardType.value = '';
    }
  }

  void clearData() {

    country.value = '';
    email.value = '';

    firstName.value = '';
    lastName.value = '';

    cardNumber.value = '';
    cvv.value = '';
    expiryDate.value = '';
  }

  @override
  void onClose() {
    clearData();
    super.onClose();
  }
}