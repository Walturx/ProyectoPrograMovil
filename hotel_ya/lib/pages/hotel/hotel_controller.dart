import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HotelPageController extends GetxController {
  final hotel = <String, dynamic>{}.obs;
  final isLoading = false.obs;

  final rooms = <Map<String, dynamic>>[].obs;
  final services = <Map<String, dynamic>>[].obs;
  final reviews = <Map<String, dynamic>>[].obs;

  int get availableRoomsCount =>
      rooms.where((room) => room['is_available'] == true).length;

  double get averageRating {
    if (reviews.isEmpty) return 0;

    final total = reviews.fold<num>(0, (sum, review) => sum + review['rating']);

    return total / reviews.length;
  }

  Future<void> loadHotelData(String hotelId) async {
    isLoading.value = true;

    final roomsJson = await rootBundle.loadString('assets/json/rooms.json');
    final roomTypesJson = await rootBundle.loadString(
      'assets/json/room_types.json',
    );
    final servicesJson = await rootBundle.loadString(
      'assets/json/services.json',
    );
    final reviewsJson = await rootBundle.loadString('assets/json/reviews.json');

    final allRooms = List<Map<String, dynamic>>.from(jsonDecode(roomsJson));
    final allRoomTypes = List<Map<String, dynamic>>.from(
      jsonDecode(roomTypesJson),
    );
    final allServices = List<Map<String, dynamic>>.from(
      jsonDecode(servicesJson),
    );
    final allReviews = List<Map<String, dynamic>>.from(jsonDecode(reviewsJson));

    rooms.value = allRooms.where((room) => room['hotel_id'] == hotelId).map((
      room,
    ) {
      final type = allRoomTypes.firstWhere(
        (t) => t['id'] == room['room_type_id'],
        orElse: () => {},
      );

      return {
        ...room,
        'type_name': type['name'] ?? 'Habitación',
        'description': type['description'] ?? '',
        'base_price': type['base_price'] ?? 0,
        'capacity': type['capacity'] ?? 0,
      };
    }).toList();

    services.value = allServices
        .where((service) => service['hotel_id'] == hotelId)
        .toList();

    reviews.value = allReviews
        .where((review) => review['hotel_id'] == hotelId)
        .toList();

    isLoading.value = false;
  }
}
