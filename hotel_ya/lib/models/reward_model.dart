// lib/models/reward_model.dart

class RewardModel {

  final String id;

  final String name;

  final String description;

  final int starsCost;

  final String type;

  final bool isActive;

  RewardModel({

    required this.id,

    required this.name,

    required this.description,

    required this.starsCost,

    required this.type,

    required this.isActive,
  });

  factory RewardModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return RewardModel(

      id:
          json['id'] as String,

      name:
          json['name']
              as String,

      description:
          json['description']
              as String,

      starsCost:
          json['stars_cost']
              as int,

      type:
          json['type']
              as String,

      isActive:
          json['is_active']
              as bool,
    );
  }

  Map<String, dynamic> toJson() {

    return {

      'id': id,

      'name': name,

      'description':
          description,

      'stars_cost':
          starsCost,

      'type': type,

      'is_active':
          isActive,
    };
  }

  RewardModel copyWith({

    String? id,

    String? name,

    String? description,

    int? starsCost,

    String? type,

    bool? isActive,
  }) {

    return RewardModel(

      id:
          id ?? this.id,

      name:
          name ?? this.name,

      description:
          description ??
              this.description,

      starsCost:
          starsCost ??
              this.starsCost,

      type:
          type ?? this.type,

      isActive:
          isActive ??
              this.isActive,
    );
  }

  @override
  String toString() {

    return '''
RewardModel(
  id: $id,
  name: $name,
  description: $description,
  starsCost: $starsCost,
  type: $type,
  isActive: $isActive
)
''';
  }
}