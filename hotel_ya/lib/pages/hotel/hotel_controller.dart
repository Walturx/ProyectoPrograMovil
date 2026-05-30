// lib/pages/hotel/hotel_controller.dart

import 'package:get/get.dart';
import 'package:hotel_ya/services/hotel_service.dart';
import 'package:hotel_ya/models/room_model.dart';
import 'package:hotel_ya/models/service_model.dart';
import 'package:hotel_ya/models/review_model.dart';

class HotelPageController extends GetxController {
  final HotelService hotelservice = HotelService();
  final hotel = <String, dynamic>{}.obs;
  final isLoading = false.obs;

  final rooms = <RoomModel>[].obs;
  final services = <ServiceModel>[].obs;
  final reviews = <ReviewModel>[].obs;

  int get availableRoomsCount =>
      rooms.where((room) => room.isAvailable == true).length;

  double get averageRating {
    if (reviews.isEmpty) return 0;

    final total = reviews.fold<num>(0, (sum, review) => sum + review.rating);

    return total / reviews.length;
  }

  Future<void> loadHotelData(String hotelId) async {
    isLoading.value = true;

    rooms.value = await hotelservice.getRoomsByHotel(hotelId);
    services.value = await hotelservice.getServicesByHotel(hotelId);
    reviews.value = await hotelservice.getReviewsByHotel(hotelId);

    isLoading.value = false;
  }
}
