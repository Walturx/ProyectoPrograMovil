// lib/pages/reservation/reservation_page.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:hotel_ya/components/wallet_bottom_nav.dart';
import 'reservation_controller.dart';

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

  // ── Getters ────────────────────────────────────────────────────────────────
  String get hotelName    => widget.hotel['name']?.toString() ?? 'Hotel';
  String get roomNumber   => widget.room['room_number']?.toString() ?? '---';
  String get roomImageUrl => widget.room['image_url']?.toString() ?? '';
  String get roomTypeName =>
      widget.roomType['name']?.toString() ??
          widget.roomType['type_name']?.toString() ??
          'Habitación';

  double get pricePerNight {
    final v = widget.roomType['base_price'];
    if (v is int) return v.toDouble();
    if (v is double) return v;
    if (v is String) return double.tryParse(v) ?? 0;
    return 0;
  }

  int get roomCapacity {
    final v = widget.roomType['capacity'];
    if (v is int) return v;
    if (v is double) return v.toInt();
    if (v is String) return int.tryParse(v) ?? 1;
    return 1;
  }

  int get maxCompanions => (roomCapacity - 1).clamp(0, 99);

  // ── Lifecycle ──────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    control = Get.put(ReservationController(), tag: UniqueKey().toString());
    control.resetReservation();
  }

  @override
  void dispose() {
    Get.delete<ReservationController>();
    super.dispose();
  }

  // ── Helpers ────────────────────────────────────────────────────────────────
  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  Future<void> _pickDate({required bool isCheckIn}) async {
    final now    = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(2100),
    );
    if (picked == null) return;
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

  void _continueReservation() {
    if (control.checkIn.value == null || control.checkOut.value == null) {
      _showSnack("Por favor seleccione check-in y check-out");
      return;
    }
    if (!control.checkOut.value!.isAfter(control.checkIn.value!)) {
      _showSnack("El check-out debe ser después del check-in");
      return;
    }
    for (final g in control.guests) {
      if (g.name.trim().isEmpty ||
          g.lastName.trim().isEmpty ||
          g.dni.trim().isEmpty ||
          g.relation.trim().isEmpty ||
          g.age <= 0) {
        _showSnack("Complete todos los datos de los acompañantes");
        return;
      }
      if (g.dni.length != 8) {
        _showSnack("El DNI debe tener 8 dígitos");
        return;
      }
    }

    final guestData = control.getGuestData();
    final nights    = control.checkOut.value!.difference(control.checkIn.value!).inDays;

    context.push('/reservation/details', extra: {
      'hotelName':   hotelName,
      'roomNumber':  int.tryParse(roomNumber) ?? 0,
      'roomType':    roomTypeName,
      'totalGuests': guestData.length + 1,
      'total':       pricePerNight * nights,
      'guests':      guestData,
      'checkIn':     control.checkIn.value!,
      'checkInHour': 12,
      'checkOut':    control.checkOut.value!,
      'checkOutHour': 12,
      'pricePerNight': pricePerNight,
    });
  }

  // ── Build ──────────────────────────────────────────────────────────────────
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

            // ── Tarjeta del hotel ──────────────────────────────────────
            _Card(children: [
              Text(hotelName,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text("$roomTypeName - HABITACIÓN $roomNumber",
                  style: const TextStyle(fontSize: 16, letterSpacing: 0.5)),
              const SizedBox(height: 12),
              if (roomImageUrl.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    roomImageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _imagePlaceholder(),
                  ),
                ),
              const SizedBox(height: 16),
              _IconRow(Icons.king_bed,
                  "Capacidad: $roomCapacity hospedantes"),
              const SizedBox(height: 8),
              _IconRow(Icons.attach_money,
                  "Precio por noche: \$${pricePerNight.toStringAsFixed(2)}",
                  bold: true),
            ]),

            const SizedBox(height: 22),

            // ── Fechas ─────────────────────────────────────────────────
            Obx(() => _DateCard(
              title: "Check-in",
              date: control.checkIn.value,
              onTap: () => _pickDate(isCheckIn: true),
            )),
            const SizedBox(height: 14),
            Obx(() => _DateCard(
              title: "Check-out",
              date: control.checkOut.value,
              onTap: () => _pickDate(isCheckIn: false),
            )),

            const SizedBox(height: 24),

            // ── Hospedantes ────────────────────────────────────────────
            _Card(children: [
              Obx(() {
                final companions = control.numberOfGuests.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Hospedantes",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text("Usuario principal: 1",
                        style: TextStyle(color: Colors.grey.shade700)),
                    Text("Acompañantes: $companions de $maxCompanions",
                        style: TextStyle(color: Colors.grey.shade700)),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: companions >= maxCompanions
                            ? null
                            : () => control.addGuest(maxCompanions),
                        icon: const Icon(Icons.person_add),
                        label: const Text("Agregar acompañante"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6CB4EE),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ]),

            const SizedBox(height: 20),

            // ── Formularios de acompañantes ────────────────────────────
            Obx(() => Column(
              children: List.generate(
                control.numberOfGuests.value,
                    (i) => _GuestForm(index: i, control: control),
              ),
            )),

            const SizedBox(height: 10),

            // ── Botón continuar ────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _continueReservation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue[200],
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("CONTINUAR",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _imagePlaceholder() => Container(
    height: 180,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(18),
    ),
    child: const Icon(Icons.image_not_supported_outlined, size: 50),
  );
}

// ── Widgets privados ──────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  final List<Widget> children;
  const _Card({required this.children});

  @override
  Widget build(BuildContext context) => Container(
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
      children: children,
    ),
  );
}

class _IconRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool bold;
  const _IconRow(this.icon, this.text, {this.bold = false});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: const Color(0xFFD4AF37)),
      const SizedBox(width: 8),
      Text(text,
          style: TextStyle(
            fontSize: bold ? 17 : 15,
            fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          )),
    ],
  );
}

class _DateCard extends StatelessWidget {
  final String title;
  final DateTime? date;
  final VoidCallback onTap;
  const _DateCard({required this.title, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) => InkWell(
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
          const Icon(Icons.calendar_month, color: Color(0xFFD4AF37)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
                const SizedBox(height: 6),
                Text(
                  date != null
                      ? DateFormat("dd/MM/yyyy").format(date!)
                      : "Seleccionar día",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text("Hora fija: 12:00",
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

class _GuestForm extends StatelessWidget {
  final int index;
  final ReservationController control;
  const _GuestForm({required this.index, required this.control});

  static final _lettersOnly = FilteringTextInputFormatter.allow(
    RegExp(r'[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]'),
  );
  static final _digitsOnly = FilteringTextInputFormatter.digitsOnly;

  @override
  Widget build(BuildContext context) {
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
          // Header
          Row(
            children: [
              const Icon(Icons.person, color: Color(0xFFD4AF37)),
              const SizedBox(width: 8),
              Expanded(
                child: Text("Acompañante ${index + 1}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              IconButton(
                onPressed: () => control.removeGuest(index),
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Nombre / Apellidos
          Row(children: [
            Expanded(child: _field(
              label: "Nombre",
              icon: Icons.badge_outlined,
              initial: guest.name,
              formatters: [_lettersOnly],
              onChanged: (v) => control.updateGuest(index, name: v),
            )),
            const SizedBox(width: 10),
            Expanded(child: _field(
              label: "Apellidos",
              icon: Icons.badge,
              initial: guest.lastName,
              formatters: [_lettersOnly],
              onChanged: (v) => control.updateGuest(index, lastName: v),
            )),
          ]),
          const SizedBox(height: 10),

          // DNI / Edad
          Row(children: [
            Expanded(child: _field(
              label: "DNI",
              icon: Icons.credit_card,
              initial: guest.dni,
              keyboard: TextInputType.number,
              maxLength: 8,
              formatters: [_digitsOnly, LengthLimitingTextInputFormatter(8)],
              onChanged: (v) => control.updateGuest(index, dni: v),
            )),
            const SizedBox(width: 10),
            Expanded(child: _field(
              label: "Edad",
              icon: Icons.cake_outlined,
              initial: guest.age == 0 ? "" : guest.age.toString(),
              keyboard: TextInputType.number,
              maxLength: 3,
              formatters: [_digitsOnly, LengthLimitingTextInputFormatter(3)],
              onChanged: (v) => control.updateGuest(index, age: int.tryParse(v) ?? 0),
            )),
          ]),
          const SizedBox(height: 10),

          // Parentesco
          _field(
            label: "Parentesco",
            icon: Icons.group_outlined,
            initial: guest.relation,
            formatters: [_lettersOnly],
            onChanged: (v) => control.updateGuest(index, relation: v),
          ),
        ],
      ),
    );
  }

  Widget _field({
    required String label,
    required IconData icon,
    required String initial,
    required ValueChanged<String> onChanged,
    List<TextInputFormatter> formatters = const [],
    TextInputType keyboard = TextInputType.name,
    int? maxLength,
  }) =>
      TextFormField(
        initialValue: initial,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          counterText: "",
        ),
        keyboardType: keyboard,
        maxLength: maxLength,
        inputFormatters: formatters,
        onChanged: onChanged,
      );
}