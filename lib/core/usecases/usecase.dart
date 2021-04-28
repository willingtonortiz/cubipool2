import 'package:dartz/dartz.dart';

import 'package:cubipool2/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> execute(Params params);
}

class NoParams {}
