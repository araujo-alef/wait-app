import 'package:waitapp/src/auth/domain/domain.dart';

class LoginModel {
  final String email;
  final String password;

  const LoginModel({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password};
  }

  factory LoginModel.fromEntity(Login login) {
    return LoginModel(email: login.email, password: login.password);
  }
}
