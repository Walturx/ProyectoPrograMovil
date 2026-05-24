class GenericResponse<T> {

  final bool success;
  final T? data;
  final String message;
  final String? error;

  GenericResponse({

    required this.success,

    this.data,

    this.message = '',

    this.error,
  });

  /// FROM JSON
  factory GenericResponse.fromJson(

    Map<String, dynamic> json, {

    T Function(dynamic)? fromJsonT,

  }) {

    return GenericResponse<T>(

      success:
          json['success'] ?? false,

      data:
          fromJsonT != null &&
                  json['data'] != null
              ? fromJsonT(json['data'])
              : json['data'],

      message:
          json['message'] ?? '',

      error:
          json['error'],
    );
  }

  /// TO JSON
  Map<String, dynamic> toJson({

    Object? Function(T)? toJsonT,

  }) {

    return {

      'success': success,

      'data':
          toJsonT != null &&
                  data != null
              ? toJsonT(data as T)
              : data,

      'message': message,

      'error': error,
    };
  }

  /// HAS ERROR
  bool get hasError {

    return error != null &&
        error!.isNotEmpty;
  }

  /// HAS DATA
  bool get hasData {

    return data != null;
  }

  /// COPY WITH
  GenericResponse<T> copyWith({

    bool? success,

    T? data,

    String? message,

    String? error,

  }) {

    return GenericResponse<T>(

      success:
          success ?? this.success,

      data:
          data ?? this.data,

      message:
          message ?? this.message,

      error:
          error ?? this.error,
    );
  }

  @override
  String toString() {

    return '''

GenericResponse(
  success: $success,
  data: $data,
  message: $message,
  error: $error
)

''';
  }
}