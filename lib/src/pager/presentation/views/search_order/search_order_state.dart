import '../../../../core/core.dart';

class SearchOrderState {
  final Order? order;

  final bool loading;

  final String error;

  SearchOrderState({
    this.order,
    this.loading = false,
    this.error = '',
  });

  SearchOrderState copyWith({
    Order? order,
    bool? loading,
    String? error,
  }) {
    return SearchOrderState(
      order: order ?? this.order,
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }

  factory SearchOrderState.initial() => SearchOrderState();
}
