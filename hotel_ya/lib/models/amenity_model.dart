class AmenityModel {
  final String id;
  final String name;
  final String icon;
  final String category;

  AmenityModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.category,
  });

  factory AmenityModel.fromJson(Map<String, dynamic> json) => AmenityModel(
        id: json['id'] as String,
        name: json['name'] as String,
        icon: json['icon'] as String,
        category: json['category'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'icon': icon,
        'category': category,
      };

  AmenityModel copyWith({
    String? id,
    String? name,
    String? icon,
    String? category,
  }) =>
      AmenityModel(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
        category: category ?? this.category,
      );
}
