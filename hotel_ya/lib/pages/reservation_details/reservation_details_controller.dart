import 'package:get/get.dart';

class ReservationDetailsController extends GetxController {
  Rx<DateTime?> checkIn = Rx<DateTime?>(null);
  Rx<DateTime?> checkOut = Rx<DateTime?>(null);

  RxInt checkInHour = 6.obs;
  RxInt checkOutHour = 6.obs;

  int numberOfGuests = 3;

  RxList<String> guestNames = <String>[].obs;
  RxList<int> guestAges = <int>[].obs;

  @override
  void onInit() {
    super.onInit();
    guestNames.clear();
    guestAges.clear();
    for (int i = 0; i < numberOfGuests; i++) {
      guestNames.add('');
      guestAges.add(0);
    }
  }

  void updateGuest(int index, String name, int age) {
    guestNames[index] = name;
    guestAges[index] = age;
  }
}