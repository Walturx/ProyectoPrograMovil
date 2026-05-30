// lib/services/hotel_service.dart

import 'dart:convert';
import 'package:flutter/services.dart';

import '../models/hotel_model.dart';
import '../models/room_model.dart';
import '../models/room_type_model.dart';
import '../models/service_model.dart';
import '../models/review_model.dart';

class HotelService {
  Future<List<HotelModel>> getHotels() async {
    final response = await rootBundle.loadString('assets/json/hotels.json');
    final data = jsonDecode(response);

    final hotelsJson = data['hotels'] as List;

    return hotelsJson.map((json) => HotelModel.fromJson(json)).toList();
  }

  Future<List<RoomModel>> getRoomsByHotel(String hotelId) async {
    final roomsJson = await rootBundle.loadString('assets/json/rooms.json');
    final roomTypesJson = await rootBundle.loadString(
      'assets/json/room_types.json',
    );

    final rooms = (jsonDecode(roomsJson) as List)
        .map((json) => RoomModel.fromJson(json))
        .toList();

    final roomTypes = (jsonDecode(roomTypesJson) as List)
        .map((json) => RoomTypeModel.fromJson(json))
        .toList();

    return rooms.where((room) => room.hotelId == hotelId).map((room) {
      final type = roomTypes.firstWhere((type) => type.id == room.roomTypeId);

      return room.copyWith(
        typeName: type.name,
        basePrice: type.basePrice,
        capacity: type.capacity,
      );
    }).toList();
  }

  Future<List<ServiceModel>> getServicesByHotel(String hotelId) async {
    final response = await rootBundle.loadString('assets/json/services.json');

    final services = (jsonDecode(response) as List)
        .map((json) => ServiceModel.fromJson(json))
        .toList();

    return services.where((service) => service.hotelId == hotelId).toList();
  }

  Future<List<ReviewModel>> getReviewsByHotel(String hotelId) async {
    final response = await rootBundle.loadString('assets/json/reviews.json');

    final reviews = (jsonDecode(response) as List)
        .map((json) => ReviewModel.fromJson(json))
        .toList();

    return reviews.where((review) => review.hotelId == hotelId).toList();
  }

  Future<RoomTypeModel?> getRoomType(String roomTypeId) async {
    final response = await rootBundle.loadString('assets/json/room_types.json');
    final roomTypes = (jsonDecode(response) as List)
        .map((json) => RoomTypeModel.fromJson(json))
        .toList();

    return roomTypes.firstWhere((type) => type.id == roomTypeId);
  }
}
