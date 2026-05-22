class ServiceModel {
  final String id;
  final String hotelId;
  final String name;
  final double price;
  final String description;

  ServiceModel({
    required this.id,
    required this.hotelId,
    required this.name,
    required this.price,
    required this.description,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json['id'] as String,
        hotelId: json['hotel_id'] as String,
        name: json['name'] as String,
        price: (json['price'] as num).toDouble(),
        description: json['description'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'hotel_id': hotelId,
        'name': name,
        'price': price,
        'description': description,
      };

  ServiceModel copyWith({
    String? id,
    String? hotelId,
    String? name,
    double? price,
    String? description,
  }) =>
      ServiceModel(
        id: id ?? this.id,
        hotelId: hotelId ?? this.hotelId,
        name: name ?? this.name,
        price: price ?? this.price,
        description: description ?? this.description,
      );
}
