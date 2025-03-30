import 'package:dartz/dartz.dart';

import '../domain.dart';

abstract class IAuthRepository {
  Future<Either<AuthFailure, bool>> login(Login loginInfo);
}
