import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../src.dart';

class SearchOrderPage extends StatefulWidget {
  final String partnerId;

  const SearchOrderPage({
    super.key,
    required this.partnerId,
  });

  @override
  State<SearchOrderPage> createState() => _SearchOrderPageState();
}

class _SearchOrderPageState extends State<SearchOrderPage> {
  final SearchOrderController controller = Modular.get<SearchOrderController>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController orderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _connectOrder(partnerId: widget.partnerId);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 100;
    final double height = MediaQuery.of(context).size.height / 100;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0XFFF2F6FC),
        body: ValueListenableBuilder(
            valueListenable: controller,
            builder: (context, state, _) {
              if (state.error.isNotEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 4, horizontal: width * 4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: height * 20),
                        Text(
                          state.error,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: const Color(0XFF5B5574),
                            fontSize: width * 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          height: height * 8,
                          child: KadButtom(
                            label: 'Entendi',
                            appearence: KadButtonAppearence.primary,
                            fontSize: width * 4,
                            onClick: controller.removeError,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }

              if (state.loading) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      KadCircularIndicator(
                        size: width * 70,
                        innerWidget: Text(
                          'Buscando seu pedido...',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: const Color(0XFF5B5574),
                            fontSize: width * 4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: height * 2),
                    ],
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.symmetric(vertical: height * 4, horizontal: width * 4),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 6),
                      child: Text(
                        'Digite o número do seu pedido',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: const Color(0XFF5B5574),
                          fontSize: width * 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 5),
                    Form(
                      key: formKey,
                      child: TextFormField(
                        controller: orderController,
                        style: GoogleFonts.inter(
                          color: const Color(0XFF323232),
                          fontSize: height * 3,
                          fontWeight: FontWeight.bold,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return 'O código do pedido não pode ser vazio';
                          return null;
                        },
                        cursorColor: const Color(0XFF5B5574),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0XFF62549F),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0XFF62549F),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0XFFEB4A3F),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0XFFEB4A3F),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorStyle: GoogleFonts.inter(
                            color: const Color(0XFFEB4A3F),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0XFFEAF0F5),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: width * 2.25,
                            vertical: height * 3,
                          ),
                          fillColor: const Color(0XFFF2F6FC),
                          filled: true,
                        ),
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: height * 8,
                      child: KadButtom(
                        label: 'Adicionar',
                        appearence: KadButtonAppearence.primary,
                        fontSize: width * 4,
                        onClick: () async {
                          if (formKey.currentState!.validate()) {
                            _connectOrder(partnerId: widget.partnerId, orderId: orderController.text);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }

  void _connectOrder({
    required String partnerId,
    String? orderId,
  }) async {
    await controller.connectOrder(partnerId: partnerId, orderId: orderId);

    if (controller.value.error.isEmpty) {
      Modular.to.pushNamed(
        '/waiting_order/${controller.value.order!.id}/${widget.partnerId}',
      );
      orderController.clear();
    }
  }
}
