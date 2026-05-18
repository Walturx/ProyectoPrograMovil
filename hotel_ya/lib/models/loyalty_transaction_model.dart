// lib/models/loyalty_transaction_model.dart

class LoyaltyTransactionModel {

  final String id;
  final String userId;
  final String reservationId;
  final String rewardRedemptionId;
  final String type;
  final int stars;
  final String description;
  final DateTime createdAt;

  LoyaltyTransactionModel({

    required this.id,
    required this.userId,
    required this.reservationId,
    required this.rewardRedemptionId,
    required this.type,
    required this.stars,
    required this.description,
    required this.createdAt,
  });

  factory LoyaltyTransactionModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return LoyaltyTransactionModel(

      id:
          json['id'] as String,

      userId:
          json['user_id']
              as String,

      reservationId:
          json['reservation_id']
              as String,

      rewardRedemptionId:
          json['reward_redemption_id']
              as String,

      type:
          json['type']
              as String,

      stars:
          json['stars']
              as int,

      description:
          json['description']
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

      'reservation_id':
          reservationId,

      'reward_redemption_id':
          rewardRedemptionId,

      'type': type,

      'stars': stars,

      'description':
          description,

      'created_at':
          createdAt
              .toIso8601String(),
    };
  }

  LoyaltyTransactionModel copyWith({

    String? id,

    String? userId,

    String? reservationId,

    String? rewardRedemptionId,

    String? type,

    int? stars,

    String? description,

    DateTime? createdAt,
  }) {

    return LoyaltyTransactionModel(

      id:
          id ?? this.id,

      userId:
          userId ??
              this.userId,

      reservationId:
          reservationId ??
              this.reservationId,

      rewardRedemptionId:
          rewardRedemptionId ??
              this.rewardRedemptionId,

      type:
          type ?? this.type,

      stars:
          stars ?? this.stars,

      description:
          description ??
              this.description,

      createdAt:
          createdAt ??
              this.createdAt,
    );
  }

  @override
  String toString() {

    return '''
LoyaltyTransactionModel(
  id: $id,
  userId: $userId,
  reservationId: $reservationId,
  rewardRedemptionId: $rewardRedemptionId,
  type: $type,
  stars: $stars,
  description: $description,
  createdAt: $createdAt
)
''';
  }
}