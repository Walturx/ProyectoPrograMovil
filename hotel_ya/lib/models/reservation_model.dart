// lib/models/reservation_model.dart

class ReservationModel {

  final String id;

  final String userId;

  final String roomId;

  final DateTime checkIn;

  final DateTime checkOut;

  final double totalPrice;

  final String status;

  final int adults;

  final int children;

  final String specialRequests;

  final DateTime createdAt;

  ReservationModel({

    required this.id,

    required this.userId,

    required this.roomId,

    required this.checkIn,

    required this.checkOut,

    required this.totalPrice,

    required this.status,

    required this.adults,

    required this.children,

    required this.specialRequests,

    required this.createdAt,
  });

  factory ReservationModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return ReservationModel(

      id:
          json['id'] as String,

      userId:
          json['user_id']
              as String,

      roomId:
          json['room_id']
              as String,

      checkIn:
          DateTime.parse(
        json['check_in']
            as String,
      ),

      checkOut:
          DateTime.parse(
        json['check_out']
            as String,
      ),

      totalPrice:
          (json['total_price']
                  as num)
              .toDouble(),

      status:
          json['status']
              as String,

      adults:
          json['adults']
              as int,

      children:
          json['children']
              as int,

      specialRequests:
          json['special_requests']
              as String,

      createdAt:
          DateTime.parse(
        json['created_at']
            as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {

    return {

      'id': id,

      'user_id':
          userId,

      'room_id':
          roomId,

      'check_in':
          checkIn
              .toIso8601String(),

      'check_out':
          checkOut
              .toIso8601String(),

      'total_price':
          totalPrice,

      'status':
          status,

      'adults':
          adults,

      'children':
          children,

      'special_requests':
          specialRequests,

      'created_at':
          createdAt
              .toIso8601String(),
    };
  }

  ReservationModel copyWith({

    String? id,

    String? userId,

    String? roomId,

    DateTime? checkIn,

    DateTime? checkOut,

    double? totalPrice,

    String? status,

    int? adults,

    int? children,

    String? specialRequests,

    DateTime? createdAt,
  }) {

    return ReservationModel(

      id:
          id ?? this.id,

      userId:
          userId ??
              this.userId,

      roomId:
          roomId ??
              this.roomId,

      checkIn:
          checkIn ??
              this.checkIn,

      checkOut:
          checkOut ??
              this.checkOut,

      totalPrice:
          totalPrice ??
              this.totalPrice,

      status:
          status ??
              this.status,

      adults:
          adults ??
              this.adults,

      children:
          children ??
              this.children,

      specialRequests:
          specialRequests ??
              this.specialRequests,

      createdAt:
          createdAt ??
              this.createdAt,
    );
  }

  @override
  String toString() {

    return '''
ReservationModel(
  id: $id,
  userId: $userId,
  roomId: $roomId,
  checkIn: $checkIn,
  checkOut: $checkOut,
  totalPrice: $totalPrice,
  status: $status,
  adults: $adults,
  children: $children,
  specialRequests: $specialRequests,
  createdAt: $createdAt
)
''';
  }
}