import 'dart:io';

extension StatusCode on int {
  // 20x
  bool get isOk => this == HttpStatus.ok;
  bool get isCreated => this == HttpStatus.created;
  bool get isNotCreated => this != HttpStatus.created;

  // 40x
  bool get isNotFound => this == HttpStatus.notFound;
  bool get isBadRequest => this == HttpStatus.badRequest;
}
