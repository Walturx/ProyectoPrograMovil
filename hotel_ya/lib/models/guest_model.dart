class GuestModel {
  final String id;
  final String reservationId;
  final String name;
  final String lastname;
  final String documentType;
  final String documentNumber;
  final String nationality;

  GuestModel({
    required this.id,
    required this.reservationId,
    required this.name,
    required this.lastname,
    required this.documentType,
    required this.documentNumber,
    required this.nationality,
  });

  factory GuestModel.fromJson(Map<String, dynamic> json) => GuestModel(
        id: json['id'] as String,
        reservationId: json['reservation_id'] as String,
        name: json['name'] as String,
        lastname: json['lastname'] as String,
        documentType: json['document_type'] as String,
        documentNumber: json['document_number'] as String,
        nationality: json['nationality'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'reservation_id': reservationId,
        'name': name,
        'lastname': lastname,
        'document_type': documentType,
        'document_number': documentNumber,
        'nationality': nationality,
      };

  GuestModel copyWith({
    String? id,
    String? reservationId,
    String? name,
    String? lastname,
    String? documentType,
    String? documentNumber,
    String? nationality,
  }) =>
      GuestModel(
        id: id ?? this.id,
        reservationId: reservationId ?? this.reservationId,
        name: name ?? this.name,
        lastname: lastname ?? this.lastname,
        documentType: documentType ?? this.documentType,
        documentNumber: documentNumber ?? this.documentNumber,
        nationality: nationality ?? this.nationality,
      );
}
