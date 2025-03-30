import 'package:dartz/dartz.dart';

import '../../domain/domain.dart';
import '../data.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDatasource _datasource;

  AuthRepository(this._datasource);

  @override
  Future<Either<AuthFailure, bool>> login(Login loginInfo) async {
    return await _datasource.login(LoginModel.fromEntity(loginInfo));
  }
}
