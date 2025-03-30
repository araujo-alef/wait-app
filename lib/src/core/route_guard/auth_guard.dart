import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login');

  @override
  Future<bool> canActivate(String path, ModularRoute route) async {
    final bool isLogged = await Modular.get<ILoggedService>().call();

    if (path == '/') return !isLogged;
    return isLogged;
  }

  Future<bool> checkCurrentUser() async {
    return FirebaseAuth.instance.currentUser != null;
  }
}
