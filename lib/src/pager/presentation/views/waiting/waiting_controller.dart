import 'package:collection/collection.dart';
import 'package:waitapp/src/pager/pager.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class WaitingController extends ValueNotifier<WaitingState> {
  final IOrdersUsecase _ordersUsecase;

  WaitingController(this._ordersUsecase) : super(WaitingState.initial());

  bool canAlert = true;

  void getOrder({
    required String orderId,
    required String partnerId,
    required VoidCallback startTimer,
    required VoidCallback onReady,
  }) async {
    if (value.order != null) await Future.delayed(const Duration(seconds: 2));

    final responseOrders = await _ordersUsecase(partnerId: partnerId);

    if (responseOrders.isLeft()) {
      getOrder(
        orderId: orderId,
        partnerId: partnerId,
        onReady: onReady,
        startTimer: startTimer,
      );
      return;
    }

    final List<Order> orders = responseOrders.toRight();

    final Order? order = orders.firstWhereOrNull(
      (order) => order.id == orderId,
    );

    if (order == null) {
      setOrderNotfFoundError();
      return;
    }

    if (value.order == null) {
      value = value.copyWith(order: order);
      startTimer.call();
    }

    final bool isReady = order.lastCall != null;

    if (isReady) {
      value = value.copyWith(isReady: isReady);
      onReady.call();
      return;
    }

    getOrder(
      orderId: orderId,
      partnerId: partnerId,
      onReady: onReady,
      startTimer: startTimer,
    );
  }

  void changedAlertType(AlertType type) {
    List<AlertType> newTypes = List.from(value.selectedAlertTypes);
    if (value.selectedAlertTypes.contains(type)) {
      newTypes.remove(type);
    } else {
      newTypes.add(type);
    }

    if (newTypes.length < 2) return;

    value = value.copyWith(selectedAlertTypes: newTypes);
  }

  void setOrderNotfFoundError() {
    value = value.copyWith(
      error:
          'Não encontramos seu pedido, verifique o código digitado ou procure um atendente',
    );
  }

  void removeError() {
    value = value.copyWith(error: '');
  }

  void changeCanAlert(bool value) {
    canAlert = value;
  }
}
