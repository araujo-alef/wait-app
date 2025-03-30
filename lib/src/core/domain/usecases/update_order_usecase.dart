import 'package:dartz/dartz.dart' hide Order;

import '../domain.dart';

abstract class IUpdateOrderUsecase {
  Future<Either<OrdersFailure, bool>> call({
    required Order order,
    String? partnerId,
  });
}

class UpdateOrderUsecase implements IUpdateOrderUsecase {
  final IOrdersRepository _repository;

  UpdateOrderUsecase(this._repository);

  @override
  Future<Either<OrdersFailure, bool>> call({
    required Order order,
    String? partnerId,
  }) async {
    return await _repository.update(order: order, partnerId: partnerId);
  }
}
