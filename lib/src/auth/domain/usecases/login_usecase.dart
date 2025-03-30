import 'package:dartz/dartz.dart';

import '../domain.dart';

abstract class ILoginUsecase {
  Future<Either<AuthFailure, bool>> call({required Login loginInfo});
}

class LoginUsecase implements ILoginUsecase {
  final IAuthRepository _repository;

  LoginUsecase(this._repository);

  @override
  Future<Either<AuthFailure, bool>> call({required Login loginInfo}) async {
    return await _repository.login(loginInfo);
  }
}
