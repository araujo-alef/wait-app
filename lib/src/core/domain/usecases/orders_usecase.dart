import 'package:dartz/dartz.dart' hide Order;

import '../domain.dart';

abstract class IOrdersUsecase {
  Future<Either<OrdersFailure, List<Order>>> call({
    String? partnerId,
  });
}

class OrdersUsecase implements IOrdersUsecase {
  final IOrdersRepository _repository;

  OrdersUsecase(this._repository);

  @override
  Future<Either<OrdersFailure, List<Order>>> call({
    String? partnerId,
  }) async {
    return await _repository.orders(partnerId: partnerId);
  }
}
