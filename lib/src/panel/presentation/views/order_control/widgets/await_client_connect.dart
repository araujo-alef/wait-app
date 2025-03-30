import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitapp/src/panel/panel.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class AwaitClientConnect extends StatefulWidget {
  final String orderId;

  final VoidCallback onCancel;

  const AwaitClientConnect({
    super.key,
    required this.orderId,
    required this.onCancel,
  });

  @override
  State<AwaitClientConnect> createState() => _AwaitClientConnectState();
}

class _AwaitClientConnectState extends State<AwaitClientConnect> {
  int _seconds = 0;

  @override
  void initState() {
    startTimer();
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
            SizedBox(height: height * 3),
            Stack(
              alignment: Alignment.center,
              children: [
                SleekCircularSlider(
                  initialValue: 29,
                  appearance: CircularSliderAppearance(
                    size: height * 33,
                    spinnerMode: true,
                    spinnerDuration: 1800,
                    angleRange: 360,
                    startAngle: 270,
                    customWidths: CustomSliderWidths(
                      progressBarWidth: height * 2.25,
                      trackWidth: height * 2.25,
                      shadowWidth: height * 3,
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
            SizedBox(height: height * 3),
            Text(
              widget.orderId,
              style: GoogleFonts.inter(
                color: const Color(0XFF5B5574),
                fontSize: height * 5,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 3),
            SizedBox(
              width: double.infinity,
              height: height * 10,
              child: KadButtom(
                label: 'Cancelar',
                appearence: KadButtonAppearence.secondary,
                onClick: () => widget.onCancel.call(),
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
