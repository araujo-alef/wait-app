import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../auth.dart';

abstract class IAuthDatasource {
  Future<Either<AuthFailure, bool>> login(LoginModel loginInfo);
}

class AuthDatasource implements IAuthDatasource {
  /// Creates a [AuthDatasource]
  AuthDatasource();

  @override
  Future<Either<AuthFailure, bool>> login(LoginModel loginInfo) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: loginInfo.email, password: loginInfo.password);
      return const Right(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(AuthFailure.userNotFound());
      } else if (e.code == 'wrong-password') {
        return Left(AuthFailure.userNotFound());
      }

      return Left(AuthFailure.unexpected());
    }
  }
}
