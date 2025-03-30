class PagerFailure {
  final String? messageError;

  const PagerFailure([this.messageError]);

  ///
  ///  Not found failure
  ///
  factory PagerFailure.notFound() => const PagerFailure();

  ///
  ///  Unexpected failure
  ///
  factory PagerFailure.unexpected() => const PagerFailure();
}
