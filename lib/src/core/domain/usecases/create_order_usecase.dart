import 'package:dartz/dartz.dart' hide Order;

import '../domain.dart';

abstract class ICreateOrderUsecase {
  Future<Either<OrdersFailure, String>> call({required Order order});
}

class CreateOrderUsecase implements ICreateOrderUsecase {
  final IOrdersRepository _repository;

  CreateOrderUsecase(this._repository);

  @override
  Future<Either<OrdersFailure, String>> call({required Order order}) async {
    return await _repository.create(order);
  }
}
