import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitapp/src/panel/panel.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AwaitClientConnect extends StatefulWidget {
  final String orderId;

  final bool addNumberLoading;

  final String error;

  final VoidCallback onCancel;

  final ValueChanged<String> onAddNumber;

  const AwaitClientConnect({
    super.key,
    required this.orderId,
    required this.error,
    required this.addNumberLoading,
    required this.onCancel,
    required this.onAddNumber,
  });

  @override
  State<AwaitClientConnect> createState() => _AwaitClientConnectState();
}

class _AwaitClientConnectState extends State<AwaitClientConnect> {
  late GlobalKey<FormState> formKey;

  static const inputBorderRadius = BorderRadius.horizontal(
    left: Radius.circular(8.0),
  );

  int _seconds = 0;

  late TextEditingController controller;

  @override
  void initState() {
    startTimer();
    controller = TextEditingController();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _seconds++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 100;
    final double height = MediaQuery.of(context).size.height / 100;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      backgroundColor: Color(0XFFFFFFFF),
      contentPadding: EdgeInsets.symmetric(
        vertical: height * 4,
        horizontal: width * 2,
      ),
      content: SizedBox(
        width: (width * 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Conectando',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                color: const Color(0XFF323232),
                fontSize: height * 3.2,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 3),
            Text(
              'Aguarde o usuário escanear o QR code.',
              style: GoogleFonts.inter(
                color: const Color(0XFF848FAD),
                fontSize: height * 3,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: height * 1),
            Stack(
              alignment: Alignment.center,
              children: [
                SleekCircularSlider(
                  initialValue: 29,
                  appearance: CircularSliderAppearance(
                    size: height * 28,
                    spinnerMode: true,
                    spinnerDuration: 1800,
                    angleRange: 360,
                    startAngle: 270,
                    customWidths: CustomSliderWidths(
                      progressBarWidth: height * 1.85,
                      trackWidth: height * 1.85,
                      shadowWidth: height * 2,
                    ),
                    customColors: CustomSliderColors(
                      dotColor: const Color(0XFFFFFFFF),
                      trackColor: const Color(0XFFEAF0F5),
                      progressBarColor: const Color(0XFF8D34D2),
                      shadowColor: const Color(0XFF8D34D2),
                    ),
                  ),
                ),
                Text(
                  _time,
                  style: GoogleFonts.inter(
                    color: const Color(0XFF5B5574),
                    fontSize: height * 4,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: height * 2),
            Text(
              widget.orderId,
              style: GoogleFonts.inter(
                color: const Color(0XFF5B5574),
                fontSize: height * 5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 1.5),
            SizedBox(
              width: double.infinity,
              height: height * 10,
              child: KadButtom(
                label: 'Cancelar',
                appearence: KadButtonAppearence.secondary,
                onClick: () => widget.onCancel.call(),
              ),
            ),
            SizedBox(height: height * 1),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      controller: controller,
                      autofocus: true,
                      inputFormatters: [
                        TextInputFormatter.withFunction((oldValue, newValue) {
                          String digits = newValue.text.replaceAll(
                            RegExp(r'\D'),
                            '',
                          );
                          if (digits.length > 11)
                            digits = digits.substring(0, 11);

                          final isCelular = digits.length > 10;
                          final pattern =
                              isCelular
                                  ? RegExp(r'^(\d{2})(\d{5})(\d{0,4})$')
                                  : RegExp(r'^(\d{2})(\d{4})(\d{0,4})$');

                          final match = pattern.firstMatch(digits);

                          if (match != null) {
                            final ddd = match.group(1);
                            final parte1 = match.group(2);
                            final parte2 = match.group(3);

                            final formatted =
                                '($ddd) $parte1${parte2 != null && parte2.isNotEmpty ? '-$parte2' : ''}';

                            return TextEditingValue(
                              text: formatted,
                              selection: TextSelection.collapsed(
                                offset: formatted.length,
                              ),
                            );
                          }

                          return TextEditingValue(
                            text: digits,
                            selection: TextSelection.collapsed(
                              offset: digits.length,
                            ),
                          );
                        }),
                      ],
                      style: GoogleFonts.inter(
                        color: const Color(0XFF323232),
                        fontSize: height * 3,
                        fontWeight: FontWeight.bold,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira um telefone!';
                        }

                        final isTelefoneValido = RegExp(
                          r'^\(\d{2}\) \d{4,5}-\d{4}$',
                        ).hasMatch(value);

                        if (!isTelefoneValido) {
                          return 'Insira um telefone válido!';
                        }

                        return null;
                      },
                      cursorColor: const Color(0XFF5B5574),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0XFF62549F),
                            width: 2.0,
                          ),
                          borderRadius: inputBorderRadius,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0XFF62549F),
                            width: 2.0,
                          ),
                          borderRadius: inputBorderRadius,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0XFFEB4A3F),
                            width: 2.0,
                          ),
                          borderRadius: inputBorderRadius,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0XFFEB4A3F),
                            width: 2.0,
                          ),
                          borderRadius: inputBorderRadius,
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
                          borderRadius: inputBorderRadius,
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
                ),
                SizedBox(width: width * 0.4),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    height: height * 9.6,
                    child: KadButtom(
                      label: 'Adicionar telefone',
                      onClick: () {
                        if (!formKey.currentState!.validate()) return;

                        widget.onAddNumber.call(controller.text);
                      },
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(8.0),
                      ),
                      child:
                          widget.addNumberLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Icon(
                                Icons.add_ic_call_outlined,
                                size: 32.0,
                                color: Colors.white,
                              ),
                    ),
                  ),
                ),
              ],
            ),
            if (widget.error.isNotEmpty)
              Text(
                widget.error,
                style: GoogleFonts.inter(
                  color: const Color(0XFFEB4A3F),
                  fontSize: height * 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
      ),
    );
  }

  String get _time {
    String minutes = (_seconds ~/ 60).toString();
    if (minutes.length == 1) minutes = '0$minutes';

    String seconds = (_seconds % 60).toString();
    if (seconds.length == 1) seconds = '0$seconds';

    return '$minutes:$seconds';
  }
}
