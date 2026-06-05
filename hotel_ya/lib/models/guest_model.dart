// lib/models/guest_model.dart

class GuestModel {
  final String id;
  final String reservationId;
  final String name;
  final String lastname;
  final String documentType;
  final String documentNumber;
  final String nationality;

  // Campos del formulario de reserva
  final String relation;
  final int age;

  GuestModel({
    this.id = '',
    this.reservationId = '',
    required this.name,
    required this.lastname,
    this.documentType = 'DNI',
    required this.documentNumber,
    this.nationality = '',
    this.relation = '',
    this.age = 0,
  });

  factory GuestModel.fromJson(Map<String, dynamic> json) => GuestModel(
    id:             json['id'] as String? ?? '',
    reservationId:  json['reservation_id'] as String? ?? '',
    name:           json['name'] as String,
    lastname:       json['lastname'] as String,
    documentType:   json['document_type'] as String? ?? 'DNI',
    documentNumber: json['document_number'] as String,
    nationality:    json['nationality'] as String? ?? '',
    relation:       json['relation'] as String? ?? '',
    age:            json['age'] as int? ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'id':              id,
    'reservation_id':  reservationId,
    'name':            name,
    'lastname':        lastname,
    'document_type':   documentType,
    'document_number': documentNumber,
    'nationality':     nationality,
    'relation':        relation,
    'age':             age,
  };

  /// Mapa simplificado para pasar entre páginas (reserva, PDF, QR)
  Map<String, dynamic> toMap() => {
    'name':     name,
    'lastName': lastname,
    'age':      age,
    'dni':      documentNumber,
    'relation': relation,
  };

  GuestModel copyWith({
    String? id,
    String? reservationId,
    String? name,
    String? lastname,
    String? documentType,
    String? documentNumber,
    String? nationality,
    String? relation,
    int? age,
  }) =>
      GuestModel(
        id:             id             ?? this.id,
        reservationId:  reservationId  ?? this.reservationId,
        name:           name           ?? this.name,
        lastname:       lastname       ?? this.lastname,
        documentType:   documentType   ?? this.documentType,
        documentNumber: documentNumber ?? this.documentNumber,
        nationality:    nationality    ?? this.nationality,
        relation:       relation       ?? this.relation,
        age:            age            ?? this.age,
      );
}