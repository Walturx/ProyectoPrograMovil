// lib/pages/reservation/reservation_controller.dart

import 'package:get/get.dart';
import '../../models/guest_model.dart';

class ReservationController extends GetxController {
  Rx<DateTime?> checkIn  = Rx<DateTime?>(null);
  Rx<DateTime?> checkOut = Rx<DateTime?>(null);
  RxInt checkInHour  = 12.obs;
  RxInt checkOutHour = 12.obs;
  RxInt numberOfGuests = 0.obs;

  /// Usa GuestModel directamente
  RxList<GuestModel> guests = <GuestModel>[].obs;

  void addGuest(int maxCompanions) {
    if (numberOfGuests.value >= maxCompanions) return;
    guests.add(GuestModel(
      name:           '',
      lastname:       '',
      documentNumber: '',
    ));
    numberOfGuests.value = guests.length;
  }

  void removeGuest(int index) {
    if (index < 0 || index >= guests.length) return;
    guests.removeAt(index);
    numberOfGuests.value = guests.length;
  }

  void updateGuest(int index, {
    String? name,
    String? lastName,
    String? dni,
    String? relation,
    int? age,
  }) {
    if (index < 0 || index >= guests.length) return;
    guests[index] = guests[index].copyWith(
      name:           name,
      lastname:       lastName,
      documentNumber: dni,
      relation:       relation,
      age:            age,
    );
    guests.refresh();
  }

  /// Devuelve la lista de mapas que esperan ReservationDetailsPage, PDF y QR
  List<Map<String, dynamic>> getGuestData() =>
      guests.map((g) => g.toMap()).toList();

  void resetReservation() {
    checkIn.value        = null;
    checkOut.value       = null;
    checkInHour.value    = 12;
    checkOutHour.value   = 12;
    numberOfGuests. value = 0;
    guests.clear();
  }
}