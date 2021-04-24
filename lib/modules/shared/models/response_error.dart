import 'dart:convert';

class ResponseError implements Exception {
  final List<String> errors;

  ResponseError({
    required this.errors,
  });

  String get firstError {
    if (errors.length == 0) {
      return 'Ocurrió un error';
    }

    return errors.first;
  }

  Map<String, dynamic> toMap() {
    return {
      'errors': errors,
    };
  }

  factory ResponseError.fromMap(Map<String, dynamic> map) {
    return ResponseError(
      errors: List<String>.from(map['errors']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ResponseError.fromJson(String source) =>
      ResponseError.fromMap(json.decode(source));

  @override
  String toString() => 'ResponseError(errors: $errors)';
}
