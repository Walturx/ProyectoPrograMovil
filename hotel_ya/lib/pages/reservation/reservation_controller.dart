// lib/pages/reservation/reservation_controller.dart

import 'package:get/get.dart';

class Guest {
  String name;
  String lastName;
  String dni;
  String relation;
  int age;

  Guest({
    this.name = '',
    this.lastName = '',
    this.dni = '',
    this.relation = '',
    this.age = 0,
  });

  Map<String, dynamic> toMap() => {
    "name": "$name $lastName",
    "age": age,
    "dni": dni,
    "relation": relation,
  };
}

class ReservationController extends GetxController {
  Rx<DateTime?> checkIn  = Rx<DateTime?>(null);
  Rx<DateTime?> checkOut = Rx<DateTime?>(null);
  RxInt checkInHour  = 12.obs;
  RxInt checkOutHour = 12.obs;
  RxInt numberOfGuests = 0.obs;
  RxList<Guest> guests = <Guest>[].obs;

  void addGuest(int maxCompanions) {
    if (numberOfGuests.value >= maxCompanions) return;
    guests.add(Guest());
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
    final g = guests[index];
    if (name != null)     g.name     = name;
    if (lastName != null) g.lastName = lastName;
    if (dni != null)      g.dni      = dni;
    if (relation != null) g.relation = relation;
    if (age != null)      g.age      = age;
    guests.refresh();
  }

  List<Map<String, dynamic>> getGuestData() =>
      guests.map((g) => g.toMap()).toList();

  void resetReservation() {
    checkIn.value  = null;
    checkOut.value = null;
    checkInHour.value  = 12;
    checkOutHour.value = 12;
    numberOfGuests.value = 0;
    guests.clear();
  }
}