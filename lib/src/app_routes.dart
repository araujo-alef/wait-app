import 'package:flutter_modular/flutter_modular.dart';
import 'package:waitapp/src/src.dart';

abstract class AppRoutes {
  /// Routes list
  static List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, __) => const LoginPage()),
    ChildRoute(
      '/order_control',
      child: (_, __) => const OrderControlPage(),
      guards: [AuthGuard()],
    ),
    ChildRoute(
      '/search_order/:partnerId',
      child: (_, args) => SearchOrderPage(partnerId: args.params['partnerId']),
    ),
    ChildRoute(
      '/waiting_order/:orderId/:partnerId',
      child:
          (_, args) => WaitingPage(
            arguments: WaitingPageArguments(
              orderId: args.params['orderId'],
              partnerId: args.params['partnerId'],
            ),
          ),
    ),
  ];
}
