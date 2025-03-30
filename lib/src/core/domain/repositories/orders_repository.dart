import 'package:dartz/dartz.dart' hide Order;

import '../domain.dart';

abstract class IOrdersRepository {
  Future<Either<OrdersFailure, String>> create(Order order);

  Future<Either<OrdersFailure, bool>> delete(String documentId);

  Future<Either<OrdersFailure, List<Order>>> orders({
    String? partnerId,
  });

  Future<Either<OrdersFailure, bool>> update({
    required Order order,
    String? partnerId,
  });

  Future<Either<OrdersFailure, bool>> logout();
}
