import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/core.dart';

class OrderItem extends StatelessWidget {
  final Order order;
  final VoidCallback onDelete;
  final VoidCallback onCall;

  const OrderItem({
    super.key,
    required this.order,
    required this.onDelete,
    required this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                order.id,
                style: GoogleFonts.inter(
                  color: const Color(0XFF848FAD),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 2.0,
              height: 42.0,
              color: const Color(0XFFEAF0F5),
            ),
            Expanded(
              flex: 2,
              child: Text(
                _time(order.creationTime),
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0XFF848FAD),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 2.0,
              height: 42.0,
              color: const Color(0XFFEAF0F5),
            ),
            Expanded(
              flex: 3,
              child: Text(
                _time(order.lastCall),
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: const Color(0XFF848FAD),
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: 2.0,
              height: 42.0,
              color: const Color(0XFFEAF0F5),
            ),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  const Spacer(flex: 2),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32.0),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0XFF7764CA).withOpacity(0.4),
                          blurRadius: 4.0,
                          spreadRadius: 0.0,
                          offset: const Offset(
                            3.0,
                            3.0,
                          ),
                        ),
                      ],
                    ),
                    height: 42,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        backgroundColor: const Color(0XFF6400B2),
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () => onCall.call(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.tap_and_play,
                              color: Colors.white,
                              size: 16.0,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Chamar',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: const Color(0XFFEAF0F5),
                    elevation: 0,
                    mini: true,
                    onPressed: () => onDelete.call(),
                    child: const Icon(
                      Icons.clear,
                      size: 24.0,
                      color: Color(0XFF848FAD),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _time(DateTime? time) {
    if (time == null) return '--:--';

    String hour = time.hour.toString();
    if (hour.length == 1) hour = '0$hour';
    String minute = time.minute.toString();
    if (minute.length == 1) minute = '0$minute';

    return '$hour:$minute';
  }
}
