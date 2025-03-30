import 'package:flutter_modular/flutter_modular.dart';

import 'auth/auth.dart';
import 'core/core.dart';
import 'pager/pager.dart';
import 'panel/panel.dart';

abstract class AppBinding {
  static List<Bind<Object>> get binds => [
        ..._infra,
        ..._datasources,
        ..._repositories,
        ..._usecases,
        ..._controllers,
      ];

  static List<Bind> get _infra => [
        Bind.factory<ILoggedService>(
          (di) => LoggedService(),
        ),
      ];

  static List<Bind> get _datasources => [
        Bind.lazySingleton<IOrdersDatasource>(
          (di) => OrdersDatasource(),
        ),
        Bind.factory<IAuthDatasource>(
          (di) => AuthDatasource(),
        ),
      ];

  static List<Bind> get _repositories => [
        Bind.factory<IAuthRepository>(
          (di) => AuthRepository(
            di<IAuthDatasource>(),
          ),
        ),
        Bind.lazySingleton<IOrdersRepository>(
          (di) => OrdersRepository(
            di.get<IOrdersDatasource>(),
          ),
        ),
      ];

  static List<Bind> get _usecases => [
        Bind.factory<ILoginUsecase>(
          (di) => LoginUsecase(
            di<IAuthRepository>(),
          ),
        ),
        Bind.lazySingleton<IOrdersUsecase>(
          (di) => OrdersUsecase(
            di.get<IOrdersRepository>(),
          ),
        ),
        Bind.lazySingleton<IUpdateOrderUsecase>(
          (di) => UpdateOrderUsecase(
            di.get<IOrdersRepository>(),
          ),
        ),
        Bind.factory<ICreateOrderUsecase>(
          (di) => CreateOrderUsecase(
            di<IOrdersRepository>(),
          ),
        ),
        Bind.factory<IDeleteOrderUsecase>(
          (di) => DeleteOrderUsecase(
            di<IOrdersRepository>(),
          ),
        ),
        Bind.factory<ILogoutUsecase>(
          (di) => LogoutUsecase(
            di<IOrdersRepository>(),
          ),
        ),
      ];

  static List<Bind> get _controllers => [
        Bind.lazySingleton<LoginController>(
          (di) => LoginController(
            di.get<ILoginUsecase>(),
          ),
        ),
        Bind.singleton<WaitingController>(
          (di) => WaitingController(
            di.get<IOrdersUsecase>(),
          ),
        ),
        Bind.lazySingleton<SearchOrderController>(
          (di) => SearchOrderController(
            di.get<IOrdersUsecase>(),
            di.get<IUpdateOrderUsecase>(),
          ),
        ),
        Bind.lazySingleton<OrderControlController>(
          (di) => OrderControlController(
            di.get<ICreateOrderUsecase>(),
            di.get<IDeleteOrderUsecase>(),
            di.get<IUpdateOrderUsecase>(),
            di.get<IOrdersUsecase>(),
            di.get<ILogoutUsecase>(),
          ),
        ),
      ];
}
