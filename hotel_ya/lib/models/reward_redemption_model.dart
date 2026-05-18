// lib/models/reward_redemption_model.dart

class RewardRedemptionModel {

  final String id;

  final String userId;

  final String rewardId;

  final String reservationId;

  final int starsSpent;

  final String status;

  final DateTime createdAt;

  RewardRedemptionModel({

    required this.id,

    required this.userId,

    required this.rewardId,

    required this.reservationId,

    required this.starsSpent,

    required this.status,

    required this.createdAt,
  });

  factory RewardRedemptionModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return RewardRedemptionModel(

      id:
          json['id'] as String,

      userId:
          json['user_id']
              as String,

      rewardId:
          json['reward_id']
              as String,

      reservationId:
          json['reservation_id']
              as String,

      starsSpent:
          json['stars_spent']
              as int,

      status:
          json['status']
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

      'reward_id':
          rewardId,

      'reservation_id':
          reservationId,

      'stars_spent':
          starsSpent,

      'status':
          status,

      'created_at':
          createdAt
              .toIso8601String(),
    };
  }

  RewardRedemptionModel copyWith({

    String? id,

    String? userId,

    String? rewardId,

    String? reservationId,

    int? starsSpent,

    String? status,

    DateTime? createdAt,
  }) {

    return RewardRedemptionModel(

      id:
          id ?? this.id,

      userId:
          userId ??
              this.userId,

      rewardId:
          rewardId ??
              this.rewardId,

      reservationId:
          reservationId ??
              this.reservationId,

      starsSpent:
          starsSpent ??
              this.starsSpent,

      status:
          status ??
              this.status,

      createdAt:
          createdAt ??
              this.createdAt,
    );
  }

  @override
  String toString() {

    return '''
RewardRedemptionModel(
  id: $id,
  userId: $userId,
  rewardId: $rewardId,
  reservationId: $reservationId,
  starsSpent: $starsSpent,
  status: $status,
  createdAt: $createdAt
)
''';
  }
}