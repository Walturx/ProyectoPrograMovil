import 'dart:convert';

class ReservationQRService {

  String generateReservationQR({

    required String hotelName,
    required String roomType,
    required int roomNumber,

    required DateTime checkIn,
    required DateTime checkOut,

    required int totalGuests,
    required double totalPrice,

    required List<Map<String, dynamic>> guests,
  }) {

    return jsonEncode({

      "hotel":
      hotelName,

      "room_type":
      roomType,

      "room_number":
      roomNumber,

      "check_in":
      checkIn.toIso8601String(),

      "check_out":
      checkOut.toIso8601String(),

      "total_guests":
      totalGuests,

      "total_price":
      totalPrice,

      "guests":
      guests,
    });
  }
}