//lib/pages/rooms/rooms_controller.dart
import 'package:get/get.dart';
import '../../models/hotel_model.dart';
import '../../models/review_model.dart';
import '../../models/room_model.dart';
import '../../models/room_type_model.dart';
import '../../models/service_model.dart';
import '../../services/hotel_service.dart';

class RoomsController extends GetxController {
  final HotelService hotelService = HotelService();

  final isLoading = false.obs;

  final room = Rxn<RoomModel>();
  final hotel = Rxn<HotelModel>();
  final roomType = Rxn<RoomTypeModel>();

  final services = <ServiceModel>[].obs;
  final reviews = <ReviewModel>[].obs;

  double get averageRating {
    if (reviews.isEmpty) return 0;

    final total = reviews.fold<num>(0, (sum, review) => sum + review.rating);

    return total / reviews.length;
  }

  Future<void> loadRoomData({
    required RoomModel selectedRoom,
    required HotelModel selectedHotel,
  }) async {
    isLoading.value = true;

    try {
      room.value = selectedRoom;
      hotel.value = selectedHotel;

      roomType.value = await hotelService.getRoomType(selectedRoom.roomTypeId);

      services.value = await hotelService.getServicesByHotel(selectedHotel.id);

      reviews.value = await hotelService.getReviewsByHotel(selectedHotel.id);
    } finally {
      isLoading.value = false;
    }
  }
}
