//hotel_ya/lib/pages/search/search_controller.dart

import 'package:get/get.dart';
import '../../models/hotel_model.dart';
import '../../services/hotel_service.dart';

class SearchPageController extends GetxController {
  final HotelService hotelService = HotelService();

  RxString searchText = ''.obs;
  RxList<HotelModel> allHotels = <HotelModel>[].obs;
  RxList<HotelModel> filteredHotels = <HotelModel>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadHotels();
  }

  Future<void> loadHotels() async {
    isLoading.value = true;

    final hotels = await hotelService.getHotels();

    allHotels.value = hotels;
    filteredHotels.value = hotels;

    isLoading.value = false;
  }

  void updateSearch(String value) {
    searchText.value = value;

    if (value.isEmpty) {
      filteredHotels.value = allHotels;
    } else {
      final query = value.toLowerCase();

      filteredHotels.value = allHotels.where((hotel) {
        final name = hotel.name.toLowerCase();
        final description = hotel.description.toLowerCase();

        return name.contains(query) || description.contains(query);
      }).toList();
    }
  }
}
