import 'package:dartz/dartz.dart' hide Order;

import '../domain.dart';

abstract class IDeleteOrderUsecase {
  Future<Either<OrdersFailure, bool>> call({required String documentId});
}

class DeleteOrderUsecase implements IDeleteOrderUsecase {
  final IOrdersRepository _repository;

  DeleteOrderUsecase(this._repository);

  @override
  Future<Either<OrdersFailure, bool>> call({required String documentId}) async {
    return await _repository.delete(documentId);
  }
}
