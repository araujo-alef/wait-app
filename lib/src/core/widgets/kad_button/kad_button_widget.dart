import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../panel/panel.dart';

class KadButtom extends StatelessWidget {
  final String label;

  final VoidCallback onClick;

  final KadButtonAppearence appearence;

  final double? fontSize;

  final BorderRadius? borderRadius;

  final Widget? child;

  const KadButtom({
    super.key,
    this.appearence = KadButtonAppearence.primary,
    this.fontSize,
    required this.label,
    required this.onClick,
    this.borderRadius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 100;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(8.0),
        ),
        backgroundColor: appearence.backgroundColor,
        shadowColor: Colors.transparent,
      ),
      onPressed: () => onClick.call(),
      child: Builder(
        builder: (context) {
          if (child != null) {
            return child!;
          }

          return Text(
            label,
            style: GoogleFonts.inter(
              color: appearence.textColor,
              fontSize: fontSize ?? height * 3,
              fontWeight: FontWeight.bold,
            ),
          );
        },
      ),
    );
  }
}
