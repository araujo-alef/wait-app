import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderInputFilter extends StatefulWidget {
  final TextEditingController filterController;

  final ValueChanged<String> onFilter;

  const OrderInputFilter({
    Key? key,
    required this.filterController,
    required this.onFilter,
  }) : super(key: key);

  @override
  State<OrderInputFilter> createState() => _OrderInputFilterState();
}

class _OrderInputFilterState extends State<OrderInputFilter> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.filterController,
      builder: (context, _) {
        return TextFormField(
          controller: widget.filterController,
          onChanged: (value) => widget.onFilter,
          style: GoogleFonts.inter(
            color: const Color(0XFF5B5574),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          cursorColor: const Color(0XFF5B5574),
          decoration: InputDecoration(
            hintText: 'Digite o código do pedido',
            hintStyle: GoogleFonts.inter(
              color: const Color(0XFF848FAD),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0XFF62549F),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Color(0XFF62549F),
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(4.0),
            ),
            fillColor: Colors.white,
            filled: true,
            suffixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: InkWell(
                onTap: () => widget.filterController.clear(),
                child: Icon(
                  widget.filterController.text.isNotEmpty
                      ? Icons.clear_outlined
                      : Icons.search_outlined,
                  size: 24,
                  color: const Color(0XFF5B5574),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
