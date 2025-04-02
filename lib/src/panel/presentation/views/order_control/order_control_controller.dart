import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:waitapp/src/core/core.dart';

import '../../../panel.dart';

class OrderControlController extends ValueNotifier<OrderControlState> {
  final ICreateOrderUsecase _createOrderUsecase;
  final IDeleteOrderUsecase _deleteOrderUsecase;
  final IUpdateOrderUsecase _updateOrderUsecase;
  final IOrdersUsecase _ordersUsecase;
  final ILogoutUsecase _logoutUsecase;

  OrderControlController(
    this._createOrderUsecase,
    this._deleteOrderUsecase,
    this._updateOrderUsecase,
    this._ordersUsecase,
    this._logoutUsecase,
  ) : super(OrderControlState.initial());

  Future<String> newOrder(String orderId) async {
    value = value.copyWith(newOrderLoading: true, error: '');

    final response = await _createOrderUsecase(
      order: Order(
        id: orderId,
        creationTime: DateTime.now(),
        clientIdentifiers: [],
        predictedTime: 120,
      ),
    );

    value = value.copyWith(newOrderLoading: false);

    return response.isRight() ? response.toRight() : '';
  }

  Future<bool> deleteOrder(String documentId) async {
    value = value.copyWith(loading: true);

    final response = await _deleteOrderUsecase(documentId: documentId);

    value = value.copyWith(loading: false);

    return response.isRight();
  }

  Future<bool> callOrder(Order order) async {
    value = value.copyWith(loading: true);

    final response = await _updateOrderUsecase(
      order: order.copyWith(lastCall: DateTime.now()),
    );

    value = value.copyWith(loading: false);

    return response.isRight();
  }

  Future<void> getOrders() async {
    value = value.copyWith(loading: true, error: '');

    final response = await _ordersUsecase();

    final newValue = response.fold(
      (l) => value.copyWith(
        error: 'Serviço indisponível, tente novamente mais tarde',
      ),
      (orders) {
        orders.sort((a, b) => a.creationTime.compareTo(b.creationTime));
        return value.copyWith(orders: orders);
      },
    );

    value = newValue.copyWith(loading: false);
  }

  Future<void> awaitConnect(String orderId) async {
    value = value.copyWith(awaitConnect: true, awaitWasCanceled: false);

    while (value.awaitConnect) {
      await Future.delayed(Duration(seconds: 5));

      final response = await _ordersUsecase();
      if (response.isRight()) {
        final Order? currentOrder = response.toRight().firstWhereOrNull(
          (order) => order.id == orderId,
        );

        final bool thereAreClient =
            currentOrder != null
                ? currentOrder.clientIdentifiers.isNotEmpty
                : false;

        if (thereAreClient) {
          value = value.copyWith(awaitConnect: false);
        }
      }
    }
  }

  void cancelAwaitConnect(String documentId) {
    value = value.copyWith(awaitConnect: false, awaitWasCanceled: true);
  }

  Future<void> logout() async {
    value = value.copyWith(loading: true, error: '');

    final response = await _logoutUsecase();

    final newValue = response.fold(
      (l) => value.copyWith(
        error: 'Serviço indisponível, tente novamente mais tarde',
      ),
      (r) => value,
    );

    value = newValue.copyWith(loading: false);
  }
}
