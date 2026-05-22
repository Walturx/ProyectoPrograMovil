class NotificationModel {
  final String id;
  final String userId;
  final String reservationId;
  final String title;
  final String body;
  final String type;
  final bool isRead;
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.reservationId,
    required this.title,
    required this.body,
    required this.type,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'] as String,
        userId: json['user_id'] as String,
        reservationId: json['reservation_id'] as String,
        title: json['title'] as String,
        body: json['body'] as String,
        type: json['type'] as String,
        isRead: (json['is_read'] == true || json['is_read'] == 1),
        createdAt: json['created_at'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'reservation_id': reservationId,
        'title': title,
        'body': body,
        'type': type,
        'is_read': isRead ? 1 : 0,
        'created_at': createdAt,
      };

  NotificationModel copyWith({
    String? id,
    String? userId,
    String? reservationId,
    String? title,
    String? body,
    String? type,
    bool? isRead,
    String? createdAt,
  }) =>
      NotificationModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        reservationId: reservationId ?? this.reservationId,
        title: title ?? this.title,
        body: body ?? this.body,
        type: type ?? this.type,
        isRead: isRead ?? this.isRead,
        createdAt: createdAt ?? this.createdAt,
      );
}
