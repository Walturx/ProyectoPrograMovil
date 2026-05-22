class RoomModel {
  final String id;
  final String hotelId;
  final String roomTypeId;
  final String roomNumber;
  final int floor;
  final bool isAvailable;
  final String imageUrl;

  // Campos de display (vienen de join con room_types)
  final String typeName;
  final double basePrice;
  final int capacity;

  RoomModel({
    required this.id,
    required this.hotelId,
    required this.roomTypeId,
    required this.roomNumber,
    required this.floor,
    required this.isAvailable,
    required this.imageUrl,
    this.typeName = '',
    this.basePrice = 0.0,
    this.capacity = 0,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
        id: json['id'] as String,
        hotelId: json['hotel_id'] as String,
        roomTypeId: json['room_type_id'] as String,
        roomNumber: json['room_number'] as String,
        floor: json['floor'] as int,
        isAvailable: (json['is_available'] == true || json['is_available'] == 1),
        imageUrl: json['image_url'] as String,
        typeName: json['type_name'] as String? ?? '',
        basePrice: (json['base_price'] as num?)?.toDouble() ?? 0.0,
        capacity: json['capacity'] as int? ?? 0,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'hotel_id': hotelId,
        'room_type_id': roomTypeId,
        'room_number': roomNumber,
        'floor': floor,
        'is_available': isAvailable ? 1 : 0,
        'image_url': imageUrl,
        'type_name': typeName,
        'base_price': basePrice,
        'capacity': capacity,
      };

  RoomModel copyWith({
    String? id,
    String? hotelId,
    String? roomTypeId,
    String? roomNumber,
    int? floor,
    bool? isAvailable,
    String? imageUrl,
    String? typeName,
    double? basePrice,
    int? capacity,
  }) =>
      RoomModel(
        id: id ?? this.id,
        hotelId: hotelId ?? this.hotelId,
        roomTypeId: roomTypeId ?? this.roomTypeId,
        roomNumber: roomNumber ?? this.roomNumber,
        floor: floor ?? this.floor,
        isAvailable: isAvailable ?? this.isAvailable,
        imageUrl: imageUrl ?? this.imageUrl,
        typeName: typeName ?? this.typeName,
        basePrice: basePrice ?? this.basePrice,
        capacity: capacity ?? this.capacity,
      );
}
