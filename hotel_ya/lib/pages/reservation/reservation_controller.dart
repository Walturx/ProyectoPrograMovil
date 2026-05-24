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

  Map<String, dynamic> toMap() {
    return {
      "name": "$name $lastName",
      "age": age,
      "dni": dni,
      "relation": relation,
    };
  }
}

class ReservationController extends GetxController {
  Rx<DateTime?> checkIn = Rx<DateTime?>(null);
  Rx<DateTime?> checkOut = Rx<DateTime?>(null);

  // Hora fija para hoteles: 12:00
  RxInt checkInHour = 12.obs;
  RxInt checkOutHour = 12.obs;

  // Solo acompañantes. El usuario principal cuenta como 1 hospedante.
  RxInt numberOfGuests = 0.obs;
  RxList<Guest> guests = <Guest>[].obs;

  void addGuest(int maxCompanions) {
    if (numberOfGuests.value < maxCompanions) {
      guests.add(Guest());
      numberOfGuests.value = guests.length;
    }
  }

  void removeGuest(int index) {
    if (index >= 0 && index < guests.length) {
      guests.removeAt(index);
      numberOfGuests.value = guests.length;
    }
  }

  void updateGuest(
      int index, {
        String? name,
        String? lastName,
        String? dni,
        String? relation,
        int? age,
      }) {
    if (index < 0 || index >= guests.length) return;

    final guest = guests[index];

    if (name != null) guest.name = name;
    if (lastName != null) guest.lastName = lastName;
    if (dni != null) guest.dni = dni;
    if (relation != null) guest.relation = relation;
    if (age != null) guest.age = age;

    guests.refresh();
  }

  List<Map<String, dynamic>> getGuestData() {
    return guests.map((guest) => guest.toMap()).toList();
  }

  void resetReservation() {
    checkIn.value = null;
    checkOut.value = null;
    checkInHour.value = 12;
    checkOutHour.value = 12;
    numberOfGuests.value = 0;
    guests.clear();
  }
}