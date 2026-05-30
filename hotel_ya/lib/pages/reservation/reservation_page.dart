import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../reservation_details/reservation_details_page.dart';
import 'reservation_controller.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final ReservationController control = Get.put(ReservationController());

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

  // Selector de fecha
  Future<void> _pickDate({required bool isCheckIn}) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      if (isCheckIn) {
        control.checkIn.value = picked;
      } else {
        control.checkOut.value = picked;
      }
    }
  }

  // Formulario de cada invitado
  Widget _buildGuestForm(int index) {
    final g = control.guests[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Acompañante ${index + 1}"),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: g.name,
                decoration: const InputDecoration(labelText: "Nombre"),
                onChanged: (val) => control.updateGuest(index, name: val),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                initialValue: g.lastName,
                decoration: const InputDecoration(labelText: "Apellidos"),
                onChanged: (val) => control.updateGuest(index, lastName: val),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                initialValue: g.dni,
                decoration: const InputDecoration(labelText: "DNI"),
                onChanged: (val) => control.updateGuest(index, dni: val),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextFormField(
                initialValue: g.relation,
                decoration: const InputDecoration(labelText: "Parentesco"),
                onChanged: (val) => control.updateGuest(index, relation: val),
              ),
            ),
          ],
        ),
        TextFormField(
          initialValue: g.age.toString(),
          decoration: const InputDecoration(labelText: "Edad"),
          keyboardType: TextInputType.number,
          onChanged: (val) =>
              control.updateGuest(index, age: int.tryParse(val) ?? 0),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Footer tipo billetera
      bottomNavigationBar: Container(
        color: const Color(0xFFDDBE5C),
        height: 60,
        child: const Center(
          child: Icon(Icons.account_balance_wallet, size: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              "Hotel XXX",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text("HABITACIÓN 102"),
            const SizedBox(height: 16),

            // Check-in
            Text("Indique checkin:"),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(),
                  child: TextButton(
                    onPressed: () => _pickDate(isCheckIn: true),
                    child: Obx(
                      () => Text(
                        control.checkIn.value != null
                            ? DateFormat(
                                "dd/MM/yyyy",
                              ).format(control.checkIn.value!)
                            : "Día",
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: _buildHourPicker(isCheckIn: true)),
              ],
            ),
            // Check-out
            Text("Indique checkout:"),
            Row(
              children: [
                TextButton(
                  onPressed: () => _pickDate(isCheckIn: false),
                  child: Obx(
                    () => Text(
                      control.checkOut.value != null
                          ? DateFormat(
                              "dd/MM/yyyy",
                            ).format(control.checkOut.value!)
                          : "Día",
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: _buildHourPicker(isCheckIn: false)),
              ],
            ),
            const SizedBox(height: 16),

            // Invitados
            Obx(
              () => Column(
                children: List.generate(
                  control.numberOfGuests.value,
                  (index) => _buildGuestForm(index),
                ),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                // Validar que check-in y check-out estén seleccionadas
                if (control.checkIn.value == null ||
                    control.checkOut.value == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Por favor seleccione fecha de check-in y check-out",
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return; // Salir sin navegar
                }

                // Generar lista de invitados con edad, DNI y parentesco
                final guestData = List.generate(control.numberOfGuests.value, (
                  i,
                ) {
                  final g = control.guests[i];
                  return {
                    "name": "${g.name} ${g.lastName}",
                    "age": g.age,
                    "dni": g.dni,
                    "relation": g.relation,
                  };
                });

                // Navegar a ReservationDetailsPage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReservationDetailsPage(
                      hotelName: "Hotel XXX",
                      roomNumber: 103,
                      guests: guestData,
                      checkIn: control.checkIn.value!,
                      checkInHour: control.checkInHour.value,
                      checkOut: control.checkOut.value!,
                      checkOutHour: control.checkOutHour.value,
                      pricePerNight: 150,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue[200],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("CONTINUAR"),
            ),
          ],
        ),
      ),
    );
  }
}
