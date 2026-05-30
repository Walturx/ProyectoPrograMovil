import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hotel_ya/components/wallet_bottom_nav.dart';
import 'reservation_controller.dart';
import 'package:go_router/go_router.dart';

class ReservationPage extends StatefulWidget {

  final Map<String, dynamic> hotel;
  final Map<String, dynamic> room;
  final Map<String, dynamic> roomType;

  const ReservationPage({
    super.key,
    required this.hotel,
    required this.room,
    required this.roomType,
  });

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  late final ReservationController control;

  // Selector de hora
  Widget _buildHourPicker({required bool isCheckIn}) {
    return Container(
      child: SizedBox(
        height: 80,
        child: ListWheelScrollView.useDelegate(
          itemExtent: 40,
          physics: const FixedExtentScrollPhysics(),
          onSelectedItemChanged: (index) {
            if (isCheckIn) {
              control.checkInHour.value = index + 6;
            } else {
              control.checkOutHour.value = index + 6;
            }
          },
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              if (index >= 0 && index <= 16) {
                return Center(child: Text("${index + 6}:00"));
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    control = Get.put(
      ReservationController(),
      tag: UniqueKey().toString(),
    );

    control.guests.clear();
    control.numberOfGuests.value = 0;
    control.checkIn.value = null;
    control.checkOut.value = null;
  }
  @override
  void dispose() {
    Get.delete<ReservationController>();
    super.dispose();
  }

  String get hotelName {
    return widget.hotel['name']?.toString() ?? 'Hotel';
  }

  String get roomNumber {
    return widget.room['room_number']?.toString() ?? '---';
  }

  String get roomImageUrl {
    return widget.room['image_url']?.toString() ?? '';
  }

  String get roomTypeName {
    return widget.roomType['name']?.toString() ??
        widget.roomType['type_name']?.toString() ??
        'Habitación';
  }

  double get pricePerNight {
    final value = widget.roomType['base_price'];

    if (value is int) return value.toDouble();
    if (value is double) return value;
    if (value is String) return double.tryParse(value) ?? 0;

    return 0;
  }

  int get roomCapacity {
    final value = widget.roomType['capacity'];

    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 1;

    return 1;
  }

  int get maxCompanions {
    final max = roomCapacity - 1;
    return max < 0 ? 0 : max;
  }

  Future<void> _pickDate({required bool isCheckIn}) async {
    final DateTime now = DateTime.now();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (isCheckIn) {
        control.checkIn.value = picked;

        if (control.checkOut.value != null &&
            !control.checkOut.value!.isAfter(picked)) {
          control.checkOut.value = null;
        }
      } else {
        control.checkOut.value = picked;
      }
    }
  }

  Widget _buildDateCard({
    required String title,
    required DateTime? date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_month,
              color: Color(0xFFD4AF37),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    date != null
                        ? DateFormat("dd/MM/yyyy").format(date)
                        : "Seleccionar día",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Hora fija: 12:00",
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestForm(int index) {
    final guest = control.guests[index];

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.person,
                color: Color(0xFFD4AF37),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  "Acompañante ${index + 1}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  control.removeGuest(index);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: guest.name,
                  decoration: const InputDecoration(
                    labelText: "Nombre",
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]'),
                    ),
                  ],
                  onChanged: (value) {
                    control.updateGuest(index, name: value);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  initialValue: guest.lastName,
                  decoration: const InputDecoration(
                    labelText: "Apellidos",
                    prefixIcon: Icon(Icons.badge),
                  ),
                  keyboardType: TextInputType.name,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]'),
                    ),
                  ],
                  onChanged: (value) {
                    control.updateGuest(index, lastName: value);
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: TextFormField(
                  initialValue: guest.dni,
                  decoration: const InputDecoration(
                    labelText: "DNI",
                    prefixIcon: Icon(Icons.credit_card),
                    counterText: "",
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 8,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(8),
                  ],
                  onChanged: (value) {
                    control.updateGuest(index, dni: value);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  initialValue: guest.age == 0 ? "" : guest.age.toString(),
                  decoration: const InputDecoration(
                    labelText: "Edad",
                    prefixIcon: Icon(Icons.cake_outlined),
                    counterText: "",
                  ),
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3),
                  ],
                  onChanged: (value) {
                    control.updateGuest(
                      index,
                      age: int.tryParse(value) ?? 0,
                    );
                  },
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          TextFormField(
            initialValue: guest.relation,
            decoration: const InputDecoration(
              labelText: "Parentesco",
              prefixIcon: Icon(Icons.group_outlined),
            ),
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]'),
              ),
            ],
            onChanged: (value) {
              control.updateGuest(index, relation: value);
            },
          ),
        ],
      ),
    );
  }

  void _continueReservation() {
    if (control.checkIn.value == null || control.checkOut.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Por favor seleccione check-in y check-out"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!control.checkOut.value!.isAfter(control.checkIn.value!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("El check-out debe ser después del check-in"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    for (final guest in control.guests) {
      if (guest.name.trim().isEmpty ||
          guest.lastName.trim().isEmpty ||
          guest.dni.trim().isEmpty ||
          guest.relation.trim().isEmpty ||
          guest.age <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Complete todos los datos de los acompañantes"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (guest.dni.length != 8) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("El DNI debe tener 8 dígitos"),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
    }

    final guestData = control.getGuestData();

    context.push(
      '/reservation/details',

      extra: {

        'hotelName': hotelName,

        'roomNumber':
        int.tryParse(roomNumber) ?? 0,

        'roomType':
        roomTypeName,

        'totalGuests':
        guestData.length + 1,

        'total':
        pricePerNight *
            control.checkOut.value!
                .difference(
              control.checkIn.value!,
            )
                .inDays,

        'guests':
        guestData,

        'checkIn':
        control.checkIn.value!,

        'checkInHour': 12,

        'checkOut':
        control.checkOut.value!,

        'checkOutHour': 12,

        'pricePerNight':
        pricePerNight,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F2EC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFDDBE5C),
        elevation: 0,
        title: const Text("Reservar habitación"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),

      ),
      bottomNavigationBar: const WalletBottomNav(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    hotelName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "$roomTypeName - HABITACIÓN $roomNumber",
                    style: const TextStyle(
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 12),

                  if (roomImageUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(
                        roomImageUrl,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.image_not_supported_outlined,
                              size: 50,
                            ),
                          );
                        },
                      ),
                    ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      const Icon(
                        Icons.king_bed,
                        color: Color(0xFFD4AF37),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Capacidad: $roomCapacity hospedantes",
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(
                        Icons.attach_money,
                        color: Color(0xFFD4AF37),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Precio por noche: \$${pricePerNight.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            Obx(
                  () => _buildDateCard(
                title: "Check-in",
                date: control.checkIn.value,
                onTap: () => _pickDate(isCheckIn: true),
              ),
            ),

            const SizedBox(height: 14),

            Obx(
                  () => _buildDateCard(
                title: "Check-out",
                date: control.checkOut.value,
                onTap: () => _pickDate(isCheckIn: false),
              ),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Obx(
                    () {
                  final companions = control.numberOfGuests.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hospedantes",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Usuario principal: 1",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),

                      Text(
                        "Acompañantes: $companions de $maxCompanions",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: companions >= maxCompanions
                              ? null
                              : () {
                            control.addGuest(maxCompanions);
                          },
                          icon: const Icon(Icons.person_add),
                          label: const Text("Agregar acompañante"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF6CB4EE),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            Obx(
                  () => Column(
                children: List.generate(
                  control.numberOfGuests.value,
                      (index) => _buildGuestForm(index),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _continueReservation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[200],
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "CONTINUAR",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}