import 'package:get/get.dart';

class Guest {
  String name;
  String lastName;
  String dni;
  String relation;
  int age;

  Guest({this.name = '', this.lastName = '', this.dni = '', this.relation = '', this.age = 0});
}

class ReservationController extends GetxController {
  // Fechas y horas
  Rx<DateTime?> checkIn = Rx<DateTime?>(null);
  Rx<DateTime?> checkOut = Rx<DateTime?>(null);
  RxInt checkInHour = 6.obs;
  RxInt checkOutHour = 6.obs;

  // Invitados
  RxInt numberOfGuests = 3.obs;
  RxList<Guest> guests = <Guest>[].obs;

  @override
  void onInit() {
    super.onInit();
    guests.value = List.generate(numberOfGuests.value, (_) => Guest());
  }

  // Actualiza datos de un invitado
  void updateGuest(int index, {String? name, String? lastName, String? dni, String? relation, int? age}) {
    final g = guests[index];
    if (name != null) g.name = name;
    if (lastName != null) g.lastName = lastName;
    if (dni != null) g.dni = dni;
    if (relation != null) g.relation = relation;
    if (age != null) g.age = age;
    guests.refresh();
  }

  // Cambiar cantidad de invitados
  void changeGuests(int count) {
    numberOfGuests.value = count;
    guests.value = List.generate(count, (_) => Guest());
  }
}