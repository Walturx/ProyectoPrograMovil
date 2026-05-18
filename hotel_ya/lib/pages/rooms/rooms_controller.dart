import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RoomsController extends GetxController {
  final isLoading = false.obs;

  final room = <String, dynamic>{}.obs;
  final hotel = <String, dynamic>{}.obs;
  final roomType = <String, dynamic>{}.obs;
  final services = <Map<String, dynamic>>[].obs;
  final reviews = <Map<String, dynamic>>[].obs;

  double get averageRating {
    if (reviews.isEmpty) return 0;

    final total = reviews.fold<num>(0, (sum, review) => sum + review['rating']);

    return total / reviews.length;
  }

  Future<void> loadRoomData({
    required Map<String, dynamic> selectedRoom,
    required Map<String, dynamic> selectedHotel,
  }) async {
    isLoading.value = true;

    try {
      room.value = selectedRoom;
      hotel.value = selectedHotel;

      final roomTypesJson = await rootBundle.loadString(
        'assets/room_types.json',
      );
      final servicesJson = await rootBundle.loadString('assets/services.json');
      final reviewsJson = await rootBundle.loadString('assets/reviews.json');

      final allRoomTypes = List<Map<String, dynamic>>.from(
        jsonDecode(roomTypesJson),
      );
      final allServices = List<Map<String, dynamic>>.from(
        jsonDecode(servicesJson),
      );
      final allReviews = List<Map<String, dynamic>>.from(
        jsonDecode(reviewsJson),
      );

      roomType.value = allRoomTypes.firstWhere(
        (type) => type['id'] == selectedRoom['room_type_id'],
        orElse: () => {},
      );

      services.value = allServices
          .where((service) => service['hotel_id'] == selectedHotel['id'])
          .toList();

      reviews.value = allReviews
          .where((review) => review['hotel_id'] == selectedHotel['id'])
          .toList();
    } catch (e) {
      print('ERROR CARGANDO ROOM DATA: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
