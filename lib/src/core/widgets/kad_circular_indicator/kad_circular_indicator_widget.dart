import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class KadCircularIndicator extends StatelessWidget {
  final Widget? innerWidget;

  final double? size;

  const KadCircularIndicator({
    super.key,
    this.innerWidget,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height / 100;

    final Widget progress = SleekCircularSlider(
      initialValue: 29,
      appearance: CircularSliderAppearance(
        size: size ?? height * 33,
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
    );

    if (innerWidget == null) {
      return progress;
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        progress,
        innerWidget!,
      ],
    );
  }
}
