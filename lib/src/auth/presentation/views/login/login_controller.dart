import 'package:flutter/material.dart';

import '../../../auth.dart';

class LoginController extends ValueNotifier<LoginState> {
  final ILoginUsecase _loginUsecase;

  LoginController(
    this._loginUsecase,
  ) : super(LoginState.initial());

  Future<void> login(String email, String password) async {
    value = value.copyWith(loading: true, error: '', success: false);

    final response = await _loginUsecase(loginInfo: Login(email: '$email@kadore.com', password: password));

    final newValue = response.fold(
      (l) => value.copyWith(
        error: 'Serviço indisponível, tente novamente mais tarde',
      ),
      (r) => value.copyWith(
        success: true,
      ),
    );

    value = newValue.copyWith(loading: false);
  }

  void changeVisibility() {
    value = value.copyWith(visibility: !value.visibility);
  }
}
