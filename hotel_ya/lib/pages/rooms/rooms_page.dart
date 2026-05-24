// hotel_ya/lib/pages/rooms/rooms_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../reservation/reservation_page.dart';
import 'rooms_controller.dart';
import 'package:go_router/go_router.dart';

class RoomPage extends StatefulWidget {
  final Map<String, dynamic> room;
  final Map<String, dynamic> hotel;

  const RoomPage({super.key, required this.room, required this.hotel});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  late final RoomsController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(RoomsController());

    controller.loadRoomData(
      selectedRoom: widget.room,
      selectedHotel: widget.hotel,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final roomData = controller.room;
        final hotelData = controller.hotel;
        final typeData = controller.roomType;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(22),

          child: Container(
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
                  hotelData['name'] ?? 'Hotel',

                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text('HABITACIÓN ${roomData['room_number']}'),

                const SizedBox(height: 10),

                Image.network(
                  roomData['image_url'] ?? '',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                const SizedBox(height: 20),

                Text(typeData['description'] ?? ''),

                const SizedBox(height: 20),

                Text(
                  'Precio: \$${typeData['base_price']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    context.go(
                      '/reservation',
                      extra: {
                        'hotel': hotelData,
                        'room': roomData,
                        'roomType': typeData,
                      },
                    );
                  },
                  child: const Text(
                    'RESERVAR',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Theme.of(context).primaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'CALIFICAR',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ), // Close Container
        ); // Close SingleChildScrollView
      }),
    );
  }
}
