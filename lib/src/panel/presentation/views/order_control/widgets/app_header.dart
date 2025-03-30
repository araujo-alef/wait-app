import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PanelHeader extends StatelessWidget {
  final VoidCallback logout;

  const PanelHeader({
    super.key,
    required this.logout,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 100;

    return Container(
      padding: EdgeInsets.symmetric(vertical: height * 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0XFF6400B2),
            const Color(0XFF8D34D2).withOpacity(0.8),
          ],
        ),
      ),
      child: Row(
        children: [
          const Spacer(flex: 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Kadore',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'e-pagers',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const Spacer(flex: 24),
          Text(
            'TIET-SP',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(flex: 1),
          Container(
            width: 2.0,
            height: 30.0,
            color: Colors.white,
          ),
          const Spacer(flex: 1),
          InkWell(
            onTap: logout.call,
            child: Row(
              children: [
                const Icon(
                  Icons.login,
                  color: Colors.white,
                  size: 24.0,
                ),
                const SizedBox(width: 12.0),
                Text(
                  'Sair',
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
