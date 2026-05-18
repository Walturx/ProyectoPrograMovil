// lib/models/user_model.dart

class UserModel {

  final String id;
  final String email;
  final String passwordHash;
  final String name;
  final String lastname;
  final String phone;
  final String documentType;
  final String documentNumber;
  final String avatarUrl;
  final String nationality;
  final int starsAvailable;

  UserModel({

    required this.id,
    required this.email,
    required this.passwordHash,
    required this.name,
    required this.lastname,
    required this.phone,
    required this.documentType,
    required this.documentNumber,
    required this.avatarUrl,
    required this.nationality,
    required this.starsAvailable,
  });

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) {

    return UserModel(

      id: json['id'] as String,
      email: json['email'] as String,
      passwordHash: json['password_hash'] as String,
      name: json['name'] as String,
      lastname: json['lastname'] as String,
      phone: json['phone'] as String,
      documentType: json['document_type'] as String,
      documentNumber: json['document_number'] as String,
      avatarUrl: json['avatar_url']as String,
      nationality: json['nationality'] as String,
      starsAvailable: json['stars_available'] as int,
    );
  }

  Map<String, dynamic> toJson() {

    return {
      'id': id,
      'email': email,
      'password_hash': passwordHash,
      'name': name,
      'lastname': lastname,
      'phone': phone,
      'document_type': documentType,
      'document_number': documentNumber,
      'avatar_url': avatarUrl,
      'nationality': nationality,
      'stars_available': starsAvailable,
    };
  }

  UserModel copyWith({

    String? id,
    String? email,
    String? passwordHash,
    String? name,
    String? lastname,
    String? phone,
    String? documentType,
    String? documentNumber,
    String? avatarUrl,
    String? nationality,
    int? starsAvailable,
  }) {

    return UserModel(

      id:
          id ?? this.id,

      email:
          email ?? this.email,

      passwordHash:
          passwordHash ??
              this.passwordHash,

      name:
          name ?? this.name,

      lastname:
          lastname ??
              this.lastname,

      phone:
          phone ?? this.phone,

      documentType:
          documentType ??
              this.documentType,

      documentNumber:
          documentNumber ??
              this.documentNumber,

      avatarUrl:
          avatarUrl ??
              this.avatarUrl,

      nationality:
          nationality ??
              this.nationality,
      
      starsAvailable:
          starsAvailable ??
              this.starsAvailable,
    );
  }

  @override
  String toString() {

    return '''
UserModel(
  id: $id,
  email: $email,
  name: $name,
  lastname: $lastname,
  phone: $phone,
  documentType: $documentType,
  documentNumber: $documentNumber,
  avatarUrl: $avatarUrl,
  nationality: $nationality
  starsAvailable: $starsAvailable
)
''';
  }
}