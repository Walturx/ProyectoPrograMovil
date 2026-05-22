class LocationModel {
  final String id;
  final String country;
  final String city;
  final String state;

  LocationModel({
    required this.id,
    required this.country,
    required this.city,
    required this.state,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json['id'] as String,
        country: json['country'] as String,
        city: json['city'] as String,
        state: json['state'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'country': country,
        'city': city,
        'state': state,
      };
}
