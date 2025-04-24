import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../panel.dart';

class CreateOrder extends StatelessWidget {
  final TextEditingController controller;

  final VoidCallback onFinish;

  final bool loading;

  const CreateOrder({
    super.key,
    required this.controller,
    required this.onFinish,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    late GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final double width = MediaQuery.of(context).size.width / 100;
    final double height = MediaQuery.of(context).size.height / 100;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(
        vertical: height * 3,
        horizontal: width * 2,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              child: Icon(
                Icons.close,
                size: height * 5,
                color: const Color(0XFF848FAD),
              ),
              onTap: () {
                if (loading) return;
                Modular.to.pop();
              },
            ),
          ),
          Text(
            'Digite o número do\npedido',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: const Color(0XFF323232),
              fontSize: height * 3.5,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: height * 3),
          Form(
            key: formKey,
            child: TextFormField(
              controller: controller,
              autofocus: true,
              style: GoogleFonts.inter(
                color: const Color(0XFF323232),
                fontSize: height * 3,
                fontWeight: FontWeight.bold,
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'O código do pedido não pode ser vazio';
                }
                return null;
              },
              cursorColor: const Color(0XFF5B5574),
              decoration: InputDecoration(
                enabled: !loading,
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
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          SizedBox(height: height * 3),
          _createOrderRowButtons(1, width, height),
          _createOrderRowButtons(3, width, height),
          _createOrderRowButtons(6, width, height),
          Row(
            children: [
              SizedBox(
                height: height * 9,
                width: width * 8,
                child: KeyboardButtom(
                  child: Icon(
                    Icons.backspace,
                    size: height * 3.25,
                    color: const Color(0XFF323232),
                  ),
                  onClick: () => _backspace(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: width * 0.8,
                  vertical: height * 0.8,
                ),
                height: height * 9,
                width: width * 8,
                child: KeyboardButtom(
                  child: const KeyBoardButtomText(text: '0'),
                  onClick: () => _setNewDigit('0'),
                ),
              ),
              SizedBox(
                height: height * 9,
                width: width * 8,
                child: KeyboardButtom(
                  color: const Color(0XFF7764CA),
                  onClick: () {
                    if (!formKey.currentState!.validate() || loading) return;
                    onFinish();
                  },
                  child:
                      loading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                            'Confirmar',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: Colors.white,
                            )
                            : Text(
                              'Confirmar',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: height * 2.5,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createOrderRowButtons(int baseNumber, double width, double height) {
    return Row(
      children: List.generate(3, (index) {
        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: index == 1 ? width * 0.8 : 0.0,
            vertical: height * 0.8,
          ),
          height: height * 9,
          width: width * 8,
          child: KeyboardButtom(
            child: KeyBoardButtomText(text: '${(index + baseNumber)}'),
            onClick: () => _setNewDigit('${(index + baseNumber)}'),
          ),
        );
      }),
    );
  }

  void _setNewDigit(String value) {
    if (loading) return;
    controller.text += value;
  }

  void _backspace() {
    if (loading) return;
    controller.text = controller.text.substring(0, controller.text.length - 1);
  }
}
