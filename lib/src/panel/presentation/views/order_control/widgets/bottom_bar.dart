import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigation extends StatefulWidget {
  final VoidCallback createOrder;

  final int pendingOrdersAmount;

  const BottomNavigation({
    super.key,
    required this.createOrder,
    required this.pendingOrdersAmount,
  });

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  String timeString = '';

  @override
  void initState() {
    timeString = _formatDateTime(DateTime.now());
    Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime time) {
    String hour = time.hour.toString();
    if (hour.length == 1) hour = '0$hour';
    String minute = time.minute.toString();
    if (minute.length == 1) minute = '0$minute';

    return '$hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0XFFEAF0F5),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 40.0),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Color(0XFF5B5574),
                    shape: BoxShape.circle,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.arrow_downward,
                      size: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Text(
                  widget.pendingOrdersAmount.toString(),
                  style: GoogleFonts.inter(
                    color: const Color(0XFF5B5574),
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4.0),
                Text(
                  'Clientes\nPendentes',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(
                    color: const Color(0XFF5B5574),
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          FloatingActionButton(
            onPressed: () => widget.createOrder.call(),
            backgroundColor: const Color(0XFF6400B2),
            child: const Icon(Icons.add, color: Colors.white, size: 32.0),
          ),
          Expanded(
            child: Text(
              timeString,
              textAlign: TextAlign.end,
              style: GoogleFonts.inter(
                color: const Color(0XFF5B5574),
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
