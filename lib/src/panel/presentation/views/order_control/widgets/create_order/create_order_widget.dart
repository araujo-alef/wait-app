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
      contentPadding: EdgeInsets.symmetric(vertical: height * 3, horizontal: width * 2),
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
          SizedBox(
            width: (width * 27) + 32,
            child: Wrap(
              spacing: width * 1,
              runSpacing: height * 2,
              children: [
                ...List.generate(
                  9,
                  (index) => SizedBox(
                    height: height * 8,
                    width: width * 9,
                    child: KeyboardButtom(
                      child: KeyBoardButtomText(text: '${(index + 1)}'),
                      onClick: () => _setNewDigit('${(index + 1)}'),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 8,
                  width: width * 9,
                  child: KeyboardButtom(
                    child: Icon(
                      Icons.backspace,
                      size: height * 3.25,
                      color: const Color(0XFF323232),
                    ),
                    onClick: () => _backspace(),
                  ),
                ),
                SizedBox(
                  height: height * 8,
                  width: width * 9,
                  child: KeyboardButtom(
                    child: const KeyBoardButtomText(text: '0'),
                    onClick: () => _setNewDigit('0'),
                  ),
                ),
                SizedBox(
                  height: height * 8,
                  width: width * 9,
                  child: KeyboardButtom(
                    color: const Color(0XFF7764CA),
                    onClick: () {
                      if (!formKey.currentState!.validate() || loading) return;
                      onFinish();
                    },
                    child: loading
                        ? const CircularProgressIndicator(color: Colors.white)
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
              ],
            ),
          ),
        ],
      ),
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
