import 'package:firebase_auth/firebase_auth.dart';

abstract class ILoggedService {
  Future<bool> call();
}

class LoggedService implements ILoggedService {
  @override
  Future<bool> call() async {
    return FirebaseAuth.instance.currentUser != null;
  }
}
