class ReviewModel {
  final String id;
  final String reservationId;
  final String userId;
  final String hotelId;
  final int rating;
  final String comment;
  final String createdAt;

  // Campo de display (viene de join con users)
  final String userName;

  ReviewModel({
    required this.id,
    required this.reservationId,
    required this.userId,
    required this.hotelId,
    required this.rating,
    required this.comment,
    required this.createdAt,
    this.userName = '',
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        id: json['id'] as String,
        reservationId: json['reservation_id'] as String,
        userId: json['user_id'] as String,
        hotelId: json['hotel_id'] as String,
        rating: json['rating'] as int,
        comment: json['comment'] as String,
        createdAt: json['created_at'] as String,
        userName: json['user_name'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'reservation_id': reservationId,
        'user_id': userId,
        'hotel_id': hotelId,
        'rating': rating,
        'comment': comment,
        'created_at': createdAt,
        'user_name': userName,
      };

  ReviewModel copyWith({
    String? id,
    String? reservationId,
    String? userId,
    String? hotelId,
    int? rating,
    String? comment,
    String? createdAt,
    String? userName,
  }) =>
      ReviewModel(
        id: id ?? this.id,
        reservationId: reservationId ?? this.reservationId,
        userId: userId ?? this.userId,
        hotelId: hotelId ?? this.hotelId,
        rating: rating ?? this.rating,
        comment: comment ?? this.comment,
        createdAt: createdAt ?? this.createdAt,
        userName: userName ?? this.userName,
      );
}
