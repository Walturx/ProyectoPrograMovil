import 'package:get/get.dart';

class ReservationDetailsController extends GetxController {
  // HOTEL
  RxString hotelName = ''.obs;

  // HABITACIÓN
  RxString roomType   = ''.obs;
  RxString roomNumber = ''.obs;
  RxInt roomCapacity  = 1.obs;

  // FECHAS
  Rx<DateTime?> checkIn  = Rx<DateTime?>(null);
  Rx<DateTime?> checkOut = Rx<DateTime?>(null);

  // PRECIOS
  RxDouble pricePerNight = 0.0.obs;
  RxDouble total         = 0.0.obs;

  // HUÉSPEDES
  RxList<Map<String, dynamic>> guests = <Map<String, dynamic>>[].obs;

  // CANTIDADES
  RxInt adults   = 0.obs;
  RxInt children = 0.obs;
  RxInt nights   = 0.obs;

  void loadReservationData({
    required String hotel,
    required String room,
    required int capacity,
    required DateTime checkInDate,
    required DateTime checkOutDate,
    required double price,
    required List<Map<String, dynamic>> guestList,
  }) {
    hotelName.value     = hotel;
    roomType.value      = room;
    roomCapacity.value  = capacity;
    checkIn.value       = checkInDate;
    checkOut.value      = checkOutDate;
    pricePerNight.value = price;
    guests.assignAll(guestList);

    nights.value   = checkOutDate.difference(checkInDate).inDays;
    total.value    = nights.value * price;
    adults.value   = guestList.where((g) => g['age'] >= 18).length;
    children.value = guestList.where((g) => g['age'] < 18).length;
  }

  void clearReservation() {
    hotelName.value     = '';
    roomType.value      = '';
    roomNumber.value    = '';
    checkIn.value       = null;
    checkOut.value      = null;
    pricePerNight.value = 0;
    total.value         = 0;
    adults.value        = 0;
    children.value      = 0;
    nights.value        = 0;
    guests.clear();
  }
}