class PaymentModel {
  final String id;
  final String reservationId;
  final double amount;
  final String method;
  final String status;
  final String paidAt;
  final String transactionId;

  PaymentModel({
    required this.id,
    required this.reservationId,
    required this.amount,
    required this.method,
    required this.status,
    required this.paidAt,
    required this.transactionId,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'] as String,
        reservationId: json['reservation_id'] as String,
        amount: (json['amount'] as num).toDouble(),
        method: json['method'] as String,
        status: json['status'] as String,
        paidAt: json['paid_at'] as String,
        transactionId: json['transaction_id'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'reservation_id': reservationId,
        'amount': amount,
        'method': method,
        'status': status,
        'paid_at': paidAt,
        'transaction_id': transactionId,
      };

  PaymentModel copyWith({
    String? id,
    String? reservationId,
    double? amount,
    String? method,
    String? status,
    String? paidAt,
    String? transactionId,
  }) =>
      PaymentModel(
        id: id ?? this.id,
        reservationId: reservationId ?? this.reservationId,
        amount: amount ?? this.amount,
        method: method ?? this.method,
        status: status ?? this.status,
        paidAt: paidAt ?? this.paidAt,
        transactionId: transactionId ?? this.transactionId,
      );
}
