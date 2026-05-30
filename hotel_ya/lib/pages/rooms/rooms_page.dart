// hotel_ya/lib/pages/rooms/rooms_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'rooms_controller.dart';
import '../../models/hotel_model.dart';
import '../../models/room_model.dart';

class RoomPage extends StatefulWidget {
  final RoomModel room;
  final HotelModel hotel;
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

        final roomData = controller.room.value;
        final hotelData = controller.hotel.value;
        final typeData = controller.roomType.value;

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
                  hotelData?.name ?? 'Hotel',

                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text('HABITACIÓN ${roomData?.roomNumber}'),

                const SizedBox(height: 10),

                Image.network(
                  roomData?.imageUrl ?? '',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                const SizedBox(height: 20),

                Text(typeData?.description ?? ''),

                const SizedBox(height: 20),

                Text(
                  'Precio: \$${typeData?.basePrice}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'RESERVAR',
                      style: TextStyle(fontSize: 16),
                    ),
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
