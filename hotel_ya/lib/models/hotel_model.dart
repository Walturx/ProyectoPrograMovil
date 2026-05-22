class HotelModel {
  final String id;
  final String locationId;
  final String name;
  final String description;
  final int stars;
  final String phone;
  final String email;
  final String coverImageUrl;
  final bool isActive;

  // Campos de display (no están en DB, se calculan o vienen de joins)
  final double rating;
  final double distanceMiles;
  final int availableRooms;
  final List<String> tags;
  final double lat;
  final double lng;

  HotelModel({
    required this.id,
    required this.locationId,
    required this.name,
    required this.description,
    required this.stars,
    required this.phone,
    required this.email,
    required this.coverImageUrl,
    required this.isActive,
    this.rating = 0.0,
    this.distanceMiles = 0.0,
    this.availableRooms = 0,
    this.tags = const [],
    this.lat = -12.0464,
    this.lng = -77.0428,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
        id: json['id'] as String,
        locationId: json['location_id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        stars: json['stars'] as int,
        phone: json['phone'] as String,
        email: json['email'] as String,
        coverImageUrl: json['cover_image_url'] as String,
        isActive: (json['is_active'] == true || json['is_active'] == 1),
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        distanceMiles: (json['distance_miles'] as num?)?.toDouble() ?? 0.0,
        availableRooms: (json['available_rooms'] as int?) ?? 0,
        tags: (json['tags'] as List<dynamic>?)?.cast<String>() ?? [],
        lat: (json['lat'] as num?)?.toDouble() ?? -12.0464,
        lng: (json['lng'] as num?)?.toDouble() ?? -77.0428,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'location_id': locationId,
        'name': name,
        'description': description,
        'stars': stars,
        'phone': phone,
        'email': email,
        'cover_image_url': coverImageUrl,
        'is_active': isActive,
        'rating': rating,
        'distance_miles': distanceMiles,
        'available_rooms': availableRooms,
        'tags': tags,
        'lat': lat,
        'lng': lng,
      };

  HotelModel copyWith({
    String? id,
    String? locationId,
    String? name,
    String? description,
    int? stars,
    String? phone,
    String? email,
    String? coverImageUrl,
    bool? isActive,
    double? rating,
    double? distanceMiles,
    int? availableRooms,
    List<String>? tags,
    double? lat,
    double? lng,
  }) =>
      HotelModel(
        id: id ?? this.id,
        locationId: locationId ?? this.locationId,
        name: name ?? this.name,
        description: description ?? this.description,
        stars: stars ?? this.stars,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        coverImageUrl: coverImageUrl ?? this.coverImageUrl,
        isActive: isActive ?? this.isActive,
        rating: rating ?? this.rating,
        distanceMiles: distanceMiles ?? this.distanceMiles,
        availableRooms: availableRooms ?? this.availableRooms,
        tags: tags ?? this.tags,
        lat: lat ?? this.lat,
        lng: lng ?? this.lng,
      );

  // ─── MOCK DATA ───────────────────────────────────────────────
  static List<HotelModel> mockList() => [
        HotelModel(
          id: 'h1',
          locationId: 'loc1',
          name: 'Hotel Country Club Lima',
          description:
              'Hotel de lujo en San Isidro con jardines históricos y piscina exterior.',
          stars: 5,
          phone: '+51 1 611 9000',
          email: 'reservas@hotelcountryclub.com',
          coverImageUrl:
              'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
          isActive: true,
          rating: 4.8,
          distanceMiles: 1.2,
          availableRooms: 6,
          tags: ['Pet Friendly', 'Piscina'],
          lat: -12.1092,
          lng: -77.0353,
        ),
        HotelModel(
          id: 'h2',
          locationId: 'loc2',
          name: 'Hilton Lima Miraflores',
          description:
              'Hotel moderno en Miraflores con vistas al Pacífico y spa completo.',
          stars: 5,
          phone: '+51 1 206 3000',
          email: 'lima@hilton.com',
          coverImageUrl:
              'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=800',
          isActive: true,
          rating: 4.6,
          distanceMiles: 2.1,
          availableRooms: 4,
          tags: ['Climate', 'Spa'],
          lat: -12.1211,
          lng: -77.0280,
        ),
        HotelModel(
          id: 'h3',
          locationId: 'loc3',
          name: 'JW Marriott Lima',
          description:
              'Frente al mar en Miraflores, restaurantes de autor y centro de negocios.',
          stars: 5,
          phone: '+51 1 217 7000',
          email: 'lima@marriott.com',
          coverImageUrl:
              'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800',
          isActive: true,
          rating: 4.7,
          distanceMiles: 2.5,
          availableRooms: 8,
          tags: ['Climate', 'Pet Friendly'],
          lat: -12.1310,
          lng: -77.0281,
        ),
        HotelModel(
          id: 'h4',
          locationId: 'loc4',
          name: 'Hotel B Barranco',
          description:
              'Boutique art hotel en Barranco, distrito bohemio de Lima.',
          stars: 4,
          phone: '+51 1 206 0800',
          email: 'reservas@hotelb.pe',
          coverImageUrl:
              'https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?w=800',
          isActive: true,
          rating: 4.5,
          distanceMiles: 3.8,
          availableRooms: 3,
          tags: ['Boutique', 'Arte'],
          lat: -12.1482,
          lng: -77.0228,
        ),
      ];

  // Hoteles trending: 5 estrellas, mayor rating primero
  static List<HotelModel> mockTrendingList() => [
        HotelModel(
          id: 'h1',
          locationId: 'loc1',
          name: 'Hotel Country Club Lima',
          description:
              'Hotel de lujo en San Isidro con jardines históricos y piscina exterior.',
          stars: 5,
          phone: '+51 1 611 9000',
          email: 'reservas@hotelcountryclub.com',
          coverImageUrl:
              'https://images.unsplash.com/photo-1566073771259-6a8506099945?w=800',
          isActive: true,
          rating: 4.8,
          distanceMiles: 1.2,
          availableRooms: 6,
          tags: ['Pet Friendly', 'Piscina'],
          lat: -12.1092,
          lng: -77.0353,
        ),
        HotelModel(
          id: 'h3',
          locationId: 'loc3',
          name: 'JW Marriott Lima',
          description:
              'Frente al mar en Miraflores, restaurantes de autor y centro de negocios.',
          stars: 5,
          phone: '+51 1 217 7000',
          email: 'lima@marriott.com',
          coverImageUrl:
              'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800',
          isActive: true,
          rating: 4.7,
          distanceMiles: 2.5,
          availableRooms: 8,
          tags: ['Climate', 'Pet Friendly'],
          lat: -12.1310,
          lng: -77.0281,
        ),
        HotelModel(
          id: 'h2',
          locationId: 'loc2',
          name: 'Hilton Lima Miraflores',
          description:
              'Hotel moderno en Miraflores con vistas al Pacífico y spa completo.',
          stars: 5,
          phone: '+51 1 206 3000',
          email: 'lima@hilton.com',
          coverImageUrl:
              'https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?w=800',
          isActive: true,
          rating: 4.6,
          distanceMiles: 2.1,
          availableRooms: 4,
          tags: ['Climate', 'Spa'],
          lat: -12.1211,
          lng: -77.0280,
        ),
      ];

  static List<HotelModel> mockPastList() => [
        HotelModel(
          id: 'h3',
          locationId: 'loc3',
          name: 'JW Marriott Lima',
          description: 'Frente al mar en Miraflores.',
          stars: 5,
          phone: '+51 1 217 7000',
          email: 'lima@marriott.com',
          coverImageUrl:
              'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?w=800',
          isActive: true,
          rating: 4.7,
          distanceMiles: 2.5,
          availableRooms: 8,
          tags: ['Climate', 'Pet Friendly'],
          lat: -12.1310,
          lng: -77.0281,
        ),
      ];
}
