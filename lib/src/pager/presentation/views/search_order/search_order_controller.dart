import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../pager.dart';

class SearchOrderController extends ValueNotifier<SearchOrderState> {
  final IOrdersUsecase _ordersUsecase;
  final IUpdateOrderUsecase _updateOrderUsecase;

  SearchOrderController(
    this._ordersUsecase,
    this._updateOrderUsecase,
  ) : super(SearchOrderState.initial());

  Future<void> connectOrder({required String partnerId, String? orderId}) async {
    value = value.copyWith(loading: true, error: '');

    final responseOrders = await _ordersUsecase(partnerId: partnerId);

    if (responseOrders.isLeft()) {
      setError();
      return;
    }

    final List<Order> orders = responseOrders.toRight();

    if (orders.isEmpty) {
      setOrderNotfFoundError();
      return;
    }

    final Order? order = orderId == null ? orders.first : orders.firstWhereOrNull((order) => order.id == orderId);

    if (order == null) {
      setOrderNotfFoundError();
      return;
    }

    List<String> clientIdentifiers = List.from(order.clientIdentifiers);
    clientIdentifiers.add('2144e134');

    final response = await _updateOrderUsecase(order: order.copyWith(clientIdentifiers: clientIdentifiers), partnerId: partnerId);

    final newValue = response.fold(
      (l) => value.copyWith(
        error: 'Serviço indisponível, tente novamente mais tarde',
      ),
      (orders) => value.copyWith(order: order),
    );

    value = newValue.copyWith(loading: false);
  }

 /*  Future<String?> getToken() async {
    return await FirebaseMessaging.instance.getToken();
  } */

  void setOrderNotfFoundError() {
    setError(message: 'Não encontramos seu pedido, verifique o código digitado ou procure um atendente');
  }

  void setError({String? message}) {
    value = value.copyWith(loading: false, error: message ?? 'Serviço indisponível, tente novamente mais tarde');
  }

  void removeError() {
    value = value.copyWith(error: '');
  }
}
