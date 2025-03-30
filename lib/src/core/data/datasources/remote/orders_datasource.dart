import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart' hide Order;
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core.dart';

const String ordersColection = "orders";

abstract class IOrdersDatasource {
  Future<Either<OrdersFailure, String>> create(OrderModel order);

  Future<Either<OrdersFailure, bool>> delete(String documentId);

  Future<List<OrderModel>> orders({
    String? partnerId,
  });

  Future<Either<OrdersFailure, bool>> update({
    required OrderModel order,
    String? partnerId,
  });

  Future<Either<OrdersFailure, bool>> logout();
}

class OrdersDatasource implements IOrdersDatasource {
  /// Creates a [OrdersDatasource]
  OrdersDatasource();

  @override
  Future<Either<OrdersFailure, String>> create(OrderModel order) async {
    String partnerId = FirebaseAuth.instance.currentUser!.uid;

    final doc = FirebaseFirestore.instance.collection(ordersColection).doc();

    try {
      final Map<String, dynamic> map = order.toJson();
      map.addAll({'documentId': doc.id});
      map.addAll({'partnerId': partnerId});
      await doc.set(map);
      return Right(doc.id);
    } catch (e) {
      return Left(OrdersFailure.unexpected());
    }
  }

  @override
  Future<Either<OrdersFailure, bool>> delete(String documentId) async {
    final doc = FirebaseFirestore.instance
        .collection(ordersColection)
        .doc(documentId);

    try {
      await doc.delete();
      return const Right(true);
    } catch (e) {
      return Left(OrdersFailure.unexpected());
    }
  }

  @override
  Future<List<OrderModel>> orders({
    String? partnerId,
  }) async {
    CollectionReference instance =
        FirebaseFirestore.instance.collection(ordersColection);

    try {
      final response = await instance.get();
      final List<OrderModel> orders =
          response.docs.map((doc) => OrderModel.fromJson(doc.data())).toList();
      return orders;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Either<OrdersFailure, bool>> update({
    required OrderModel order,
    String? partnerId,
  }) async {
    final doc = FirebaseFirestore.instance
        .collection(ordersColection)
        .doc(order.documentId);
    try {
      await doc.update(order.toJson());
      return const Right(true);
    } catch (e) {
      return Left(OrdersFailure.unexpected());
    }
  }

  @override
  Future<Either<OrdersFailure, bool>> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(true);
    } on FirebaseAuthException {
      return Left(OrdersFailure.unexpected());
    }
  }
}
