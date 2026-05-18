//hotel_ya/lib/pages/search/search_controller.dart
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  RxString searchText = ''.obs;
  RxList<dynamic> allHotels = <dynamic>[].obs;
  RxList<dynamic> filteredHotels = <dynamic>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadHotels();
  }

  Future<void> loadHotels() async {
    final String response =
        await rootBundle.loadString('assets/json/hotels.json');
    final data = json.decode(response);

    allHotels.value = data['hotels'];
    filteredHotels.value = allHotels;
    isLoading.value = false;
  }

  void updateSearch(String value) {
    searchText.value = value;

    if (value.isEmpty) {
      filteredHotels.value = allHotels;
    } else {
      filteredHotels.value = allHotels.where((hotel) {
        final name = hotel['name'].toString().toLowerCase();
        final description = hotel['description'].toString().toLowerCase();
        final query = value.toLowerCase();
        return name.contains(query) || description.contains(query);
      }).toList();
    }
  }
}
