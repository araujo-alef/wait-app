import 'package:dartz/dartz.dart' hide Order;

import '../../core.dart';

class OrdersRepository implements IOrdersRepository {
  final IOrdersDatasource _datasource;

  OrdersRepository(this._datasource);

  @override
  Future<Either<OrdersFailure, String>> create(Order order) async {
    return await _datasource.create(OrderModel.fromEntity(order));
  }

  @override
  Future<Either<OrdersFailure, bool>> delete(String documentId) async {
    return await _datasource.delete(documentId);
  }

  @override
  Future<Either<OrdersFailure, List<Order>>> orders({
    String? partnerId,
  }) async {
    try {
      final response = await _datasource.orders(partnerId: partnerId);

      return Right(response.map((e) => e.toEntity()).toList());
    } catch (e) {
      return const Left(OrdersFailure());
    }
  }

  @override
  Future<Either<OrdersFailure, bool>> logout() async {
    return await _datasource.logout();
  }

  @override
  Future<Either<OrdersFailure, bool>> update({
    required Order order,
    String? partnerId,
  }) async {
    return await _datasource.update(order: OrderModel.fromEntity(order), partnerId: partnerId);
  }
}
