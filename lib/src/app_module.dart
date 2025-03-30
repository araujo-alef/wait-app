import 'package:flutter_modular/flutter_modular.dart';

import 'src.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => AppBinding.binds;

  @override
  List<ModularRoute> get routes => AppRoutes.routes;
}
