import 'package:flutter/material.dart';

enum KadButtonAppearence {
  primary(
    backgroundColor: Color(0XFF7764CA),
    textColor: Color(0XFFFFFFFF),
  ),
  secondary(
    backgroundColor: Color(0XFFEAF0F5),
    textColor: Color(0XFF5B5574),
  );

  const KadButtonAppearence({
    required this.backgroundColor,
    required this.textColor,
  });

  final Color backgroundColor;
  final Color textColor;
}
