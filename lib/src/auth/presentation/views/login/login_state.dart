class LoginState {
  final bool loading;

  final bool visibility;

  final bool success;

  final String error;

  LoginState({
    this.loading = false,
    this.visibility = false,
    this.success = false,
    this.error = '',
  });

  LoginState copyWith({
    bool? loading,
    bool? visibility,
    bool? success,
    String? error,
  }) {
    return LoginState(
      loading: loading ?? this.loading,
      visibility: visibility ?? this.visibility,
      success: success ?? this.success,
      error: error ?? this.error,
    );
  }

  factory LoginState.initial() => LoginState();
}
