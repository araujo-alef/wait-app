import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderLabel extends StatelessWidget {
  final String label;

  final int? flex;

  const OrderLabel(
    this.label, {
    super.key,
    this.flex,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex ?? 1,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.inter(
          color: const Color(0XFF5B5574),
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
