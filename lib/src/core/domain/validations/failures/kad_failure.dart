class OrdersFailure {
  final String? messageError;

  const OrdersFailure([this.messageError]);

  ///
  ///  Not found failure
  ///
  factory OrdersFailure.notFound() => const OrdersFailure();

  ///
  ///  Unexpected failure
  ///
  factory OrdersFailure.unexpected() => const OrdersFailure();
}
