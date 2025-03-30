import 'package:dartz/dartz.dart';

import '../../core.dart';

abstract class ILogoutUsecase {
  Future<Either<OrdersFailure, bool>> call();
}

class LogoutUsecase implements ILogoutUsecase {
  final IOrdersRepository _repository;

  LogoutUsecase(this._repository);

  @override
  Future<Either<OrdersFailure, bool>> call() async {
    return await _repository.logout();
  }
}
