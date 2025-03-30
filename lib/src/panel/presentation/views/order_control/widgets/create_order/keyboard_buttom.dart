import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KeyboardButtom extends StatelessWidget {
  final Widget child;

  final VoidCallback onClick;

  final Color? color;

  const KeyboardButtom({
    super.key,
    this.color,
    required this.child,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        backgroundColor: color ?? const Color(0XFFEEEEEE),
        shadowColor: Colors.transparent,
      ),
      onPressed: () => onClick.call(),
      child: child,
    );
  }
}

class KeyBoardButtomText extends StatelessWidget {
  final String text;

  const KeyBoardButtomText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 100;

    return Text(
      text,
      style: GoogleFonts.inter(
        color: const Color(0XFF323232),
        fontSize: height * 3.75,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
