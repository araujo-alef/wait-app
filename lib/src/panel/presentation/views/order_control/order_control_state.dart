import '../../../../core/core.dart';

class OrderControlState {
  final bool loading;

  final bool newOrderLoading;

  final bool awaitConnect;

  final bool awaitWasCanceled;

  final String error;

  final List<Order> orders;

  OrderControlState({
    this.loading = false,
    this.newOrderLoading = false,
    this.awaitConnect = true,
    this.awaitWasCanceled = false,
    this.error = '',
    this.orders = const [],
  });

  OrderControlState copyWith({
    bool? loading,
    bool? newOrderLoading,
    bool? awaitConnect,
    bool? awaitWasCanceled,
    String? error,
    List<Order>? orders,
  }) {
    return OrderControlState(
      loading: loading ?? this.loading,
      newOrderLoading: newOrderLoading ?? this.newOrderLoading,
      awaitConnect: awaitConnect ?? this.awaitConnect,
      awaitWasCanceled: awaitWasCanceled ?? this.awaitWasCanceled,
      error: error ?? this.error,
      orders: orders ?? this.orders,
    );
  }

  factory OrderControlState.initial() => OrderControlState();
}
