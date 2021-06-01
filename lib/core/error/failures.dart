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
    if (map.containsKey('message')) {
      return ServerFailure(
        List<String>.from(map['message']),
      );
    } else if (map.containsKey('error')) {
      return ServerFailure([map['error']]);
    } else {
      print(map);
      return ServerFailure(
        List<String>.from(map['errors']),
      );
    }
  }

  @override
  String toString() => 'ServerFailure(errors: $errors)';
}
