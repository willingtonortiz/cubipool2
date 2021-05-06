abstract class Failure {}

class ServerFailure extends Failure {
  final List<String> errors;

  ServerFailure(this.errors);

  String get firstError {
    if (errors.length == 0) {
      return 'Ocurrió un error';
    }

    return errors.first;
  }

  factory ServerFailure.fromMap(Map<String, dynamic> map) {
    if (map.containsKey('error')) {
      return ServerFailure([map['error']]);
    } else {
      return ServerFailure(
        List<String>.from(map['errors']),
      );
    }
  }
}