class RoomTypeModel {
  final String id;
  final String name;
  final String description;
  final double basePrice;
  final int capacity;

  RoomTypeModel({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.capacity,
  });

  factory RoomTypeModel.fromJson(Map<String, dynamic> json) => RoomTypeModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        basePrice: (json['base_price'] as num).toDouble(),
        capacity: json['capacity'] as int,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'base_price': basePrice,
        'capacity': capacity,
      };

  RoomTypeModel copyWith({
    String? id,
    String? name,
    String? description,
    double? basePrice,
    int? capacity,
  }) =>
      RoomTypeModel(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        basePrice: basePrice ?? this.basePrice,
        capacity: capacity ?? this.capacity,
      );
}
