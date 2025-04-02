import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/core.dart';
import '../../../panel.dart';

class OrderControlPage extends StatefulWidget {
  const OrderControlPage({super.key});

  @override
  State<OrderControlPage> createState() => _OrderControlPageState();
}

class _OrderControlPageState extends State<OrderControlPage> {
  final OrderControlController _controller =
      Modular.get<OrderControlController>();

  late ScrollController _scrollController;
  late TextEditingController _filterController;
  late TextEditingController _newOrderController;

  String value = '';

  @override
  void initState() {
    super.initState();
    _controller.getOrders();
    _listenOrders();
    _scrollController = ScrollController();
    _filterController = TextEditingController();
    _newOrderController = TextEditingController();
  }

  void _listenOrders() {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child('orders');

    ref.onValue.listen(
      (event) {
        setState(() {
          value = event.snapshot.value.toString();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 100;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0XFFF2F6FC),
        body: Column(
          children: [
            Text(value),
            PanelHeader(
              logout: () async {
                await _controller.logout();
                if (FirebaseAuth.instance.currentUser == null) {
                  Modular.to.pushReplacementNamed('/');
                }
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40.0, vertical: 12.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const OrderLabel('Pedido', flex: 3),
                        const OrderLabel('Horário', flex: 2),
                        const OrderLabel('Último chamado', flex: 3),
                        const Spacer(),
                        Expanded(
                          flex: 3,
                          child: OrderInputFilter(
                            filterController: _filterController,
                            onFilter: (_) {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    ValueListenableBuilder(
                        valueListenable: _controller,
                        builder: (context, state, child) {
                          if (state.loading) {
                            return const Expanded(
                                child: KadCircularIndicator());
                          }

                          if (state.error.isNotEmpty) {
                            return Expanded(
                              child: SizedBox(
                                width: width * 50,
                                child: Center(
                                  child: message(state.error),
                                ),
                              ),
                            );
                          }

                          if (state.orders.isEmpty) {
                            return Expanded(
                              child: SizedBox(
                                width: width * 35,
                                child: Center(
                                  child: message(
                                      'Para começar adicione um pedido'),
                                ),
                              ),
                            );
                          }

                          return Expanded(
                            child: RawScrollbar(
                              controller: _scrollController,
                              thumbVisibility: true,
                              trackVisibility: true,
                              trackBorderColor: Colors.transparent,
                              thumbColor: const Color(0XFFD5D5D5),
                              trackColor: const Color(0XFFEEEEEE),
                              radius: const Radius.circular(24.0),
                              trackRadius: const Radius.circular(24),
                              child: ScrollConfiguration(
                                behavior:
                                    ScrollConfiguration.of(context).copyWith(
                                  scrollbars: false,
                                  dragDevices: {
                                    PointerDeviceKind.touch,
                                    PointerDeviceKind.mouse,
                                  },
                                ),
                                child: AnimatedBuilder(
                                    animation: _filterController,
                                    builder: (context, snapshot) {
                                      return ListView.separated(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, right: 24.0),
                                        physics: const BouncingScrollPhysics(),
                                        controller: _scrollController,
                                        shrinkWrap: true,
                                        itemCount: orders.length,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(height: 12.0),
                                        itemBuilder: (_, index) {
                                          final Order order = orders[index];

                                          return OrderItem(
                                            order: order,
                                            onDelete: () => _deleteOrder(
                                              context,
                                              order.documentId!,
                                            ),
                                            onCall: () => _callOrder(
                                              context,
                                              order,
                                            ),
                                          );
                                        },
                                      );
                                    }),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, state, child) {
              if (state.loading || state.error.isNotEmpty) {
                return const SizedBox.shrink();
              }

              return BottomNavigation(
                pendingOrdersAmount: state.orders.length,
                createOrder: () => showCreateOrderAlert(context),
              );
            }),
      ),
    );
  }

  List<Order> get orders {
    if (_filterController.text.isEmpty) return _controller.value.orders;

    return _controller.value.orders
        .where((order) => order.id.contains(_filterController.text))
        .toList();
  }

  void showCreateOrderAlert(BuildContext context) async {
    final String? documentId = await showDialog<String?>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ValueListenableBuilder(
          valueListenable: _controller,
          builder: (context, state, child) {
            return CreateOrder(
              controller: _newOrderController,
              loading: _controller.value.newOrderLoading,
              onFinish: () async {
                final String documentId =
                    await _controller.newOrder(_newOrderController.text);
                Modular.to.pop(documentId);
              },
            );
          },
        );
      },
    );

    if (documentId == null) {
      _newOrderController.clear();
      return;
    }

    if (documentId.isEmpty) {
      if (context.mounted) {
        _showError(
            context, 'Não foi possível adicionar o pedido. Tente novamente');
        _newOrderController.clear();
        return;
      }
    }

    if (context.mounted) shoAwaitClientConnectAlert(context, documentId);
  }

  void shoAwaitClientConnectAlert(
      BuildContext context, String documentId) async {
    final String orderId = _newOrderController.text;

    _newOrderController.clear();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ValueListenableBuilder(
          valueListenable: _controller,
          builder: (context, state, child) {
            return AwaitClientConnect(
              orderId: orderId,
              onCancel: () => _controller.cancelAwaitConnect(documentId),
            );
          },
        );
      },
    );

    await _controller.awaitConnect(orderId);
    Modular.to.pop();
    if (_controller.value.awaitWasCanceled) {
      await _controller.deleteOrder(documentId);
    }
    _controller.getOrders();
  }

  Widget message(String message) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: GoogleFonts.inter(
        color: const Color(0XFF5B5574),
        fontSize: 40.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void _deleteOrder(BuildContext context, String documentId) async {
    final bool deleted = await _controller.deleteOrder(documentId);

    if (deleted) {
      _controller.getOrders();
      return;
    }

    if (context.mounted) {
      _showError(context, 'Não foi possível excluir o pedido. Tente novamente');
    }
  }

  void _callOrder(BuildContext context, Order order) async {
    final bool called = await _controller.callOrder(order);

    if (called) {
      _controller.getOrders();
      return;
    }

    if (mounted) {
      _showError(context, 'Não foi possível excluir o pedido. Tente novamente');
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0XFFff6f65),
      ),
    );
  }
}
