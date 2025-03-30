class AuthFailure {
  final String? messageError;

  const AuthFailure([this.messageError]);

  /// User notfound
  factory AuthFailure.userNotFound({String? message}) => AuthFailure(message);

  ///
  ///  Wrong password failure
  ///
  factory AuthFailure.wrongPassword() => const AuthFailure();

  ///
  ///  Unexpected failure
  ///
  factory AuthFailure.unexpected() => const AuthFailure();
}
