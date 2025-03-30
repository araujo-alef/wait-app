import 'dart:async';

import 'package:waitapp/src/pager/pager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import '../../../../core/core.dart';

class WaitingPageArguments {
  final String orderId;
  final String partnerId;
  WaitingPageArguments({required this.orderId, required this.partnerId});
}

class WaitingPage extends StatefulWidget {
  final WaitingPageArguments arguments;

  const WaitingPage({super.key, required this.arguments});

  @override
  State<WaitingPage> createState() => _WaitingPageState();
}

class _WaitingPageState extends State<WaitingPage> {
  final WaitingController _controller = Modular.get<WaitingController>();

  int _totalTime = 0;

  int _countTime = 0;

  @override
  void initState() {
    super.initState();
    _getOrder();
  }

  void _startTimer() {
    final Order order = _controller.value.order!;

    final difference = DateTime.now().difference(order.creationTime).inMinutes;

    _totalTime = (order.predictedTime - difference) * 60;

    if (_totalTime <= 0) {
      _totalTime = 60;
      _countTime = 60;
      return;
    }

    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countTime < _totalTime) {
          _countTime++;
        } else {
          _countTime = 0;
        }
      });
    });
  }

  void _getOrder() {
    _controller.getOrder(
      orderId: widget.arguments.orderId,
      partnerId: widget.arguments.partnerId,
      onReady: _onReady,
      startTimer: _startTimer,
    );
  }

  void _onReady() async {
    /* await player.setAsset('assets/audio/alert.mp3');
    player.play(); */
    /*  for (var i = 0; i < 4; i++) {
      js.context.callMethod('eval', ['navigator.vibrate(600);']);
      player.play();
      await Future.delayed(const Duration(milliseconds: 2000));
      player.pause();
    } */
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 100;
    final double height = MediaQuery.of(context).size.height / 100;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0XFFF2F6FC),
        body: ValueListenableBuilder(
          valueListenable: _controller,
          builder: (context, state, _) {
            if (state.error.isNotEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 4,
                    horizontal: width * 4,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 20),
                      Text(
                        state.error,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: const Color(0XFF5B5574),
                          fontSize: width * 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        height: height * 8,
                        child: KadButtom(
                          label: 'Entendi',
                          appearence: KadButtonAppearence.primary,
                          fontSize: width * 4,
                          onClick: () {
                            _controller.removeError();
                            _getOrder();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state.order == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    KadCircularIndicator(
                      size: width * 70,
                      innerWidget: Text(
                        'Buscando seu pedido...',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: const Color(0XFF5B5574),
                          fontSize: width * 4,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 2),
                  ],
                ),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: height * 4),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 10),
                      child: Text(
                        state.isReady
                            ? 'Seu pedido está pronto'
                            : 'Estamos preparando seu pedido',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: const Color(0XFF5B5574),
                          fontSize: width * 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 4),
                    SleekCircularSlider(
                      initialValue: _countTime.toDouble(),
                      max: _totalTime.toDouble(),
                      innerWidget: (_) {
                        if (state.isReady) {
                          return Icon(
                            Icons.check,
                            size: height * 24,
                            color: const Color(0XFF5B5574),
                          );
                        }

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateTime.now().toString(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: const Color(0XFF848FAD),
                                fontSize: width * 6,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 2),
                            Text(
                              _timer,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: const Color(0XFF5B5574),
                                fontSize: width * 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      },
                      appearance: CircularSliderAppearance(
                        size: width * 72,
                        angleRange: 360,
                        startAngle: 270,
                        customWidths: CustomSliderWidths(
                          progressBarWidth: height * 3,
                          trackWidth: height * 3,
                          shadowWidth: height * 4,
                        ),
                        customColors: CustomSliderColors(
                          dotColor: const Color(0XFFFFFFFF),
                          trackColor: const Color(0XFFEAF0F5),
                          progressBarColor: const Color(0XFF8D34D2),
                          shadowColor: const Color(0XFF8D34D2),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 4),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 10),
                      child: Text(
                        state.order!.id,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          color: const Color(0XFF5B5574),
                          fontSize: width * 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 4),
                    /* Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 4),
                      child: RichText(
                        text: TextSpan(
                          text:
                              'Como podemos avisá-lo quando seu pedido estiver pronto? ',
                          style: GoogleFonts.inter(
                            color: const Color(0XFF848FAD),
                            fontSize: width * 4,
                            fontWeight: FontWeight.w600,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' (minímo 2 opções)',
                              style: GoogleFonts.inter(
                                color: const Color(0XFF848FAD),
                                fontSize: width * 3,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ), */
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 4),
                      child: Text(
                        'Você será avisado quando seu pedido estiver pronto',
                        style: GoogleFonts.inter(
                          color: const Color(0XFF848FAD),
                          fontSize: width * 4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 3),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 10),
                      child: Wrap(
                        spacing: width * 14,
                        runSpacing: height * 2,
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          alertTypeButtom(
                            context,
                            Icons.volume_up_outlined,
                            'Tocar',
                            AlertType.play,
                          ),
                          alertTypeButtom(
                            context,
                            Icons.notifications_outlined,
                            'Notificar',
                            AlertType.notify,
                          ),
                          alertTypeButtom(
                            context,
                            Icons.vibration_outlined,
                            'Vibrar',
                            AlertType.vibrate,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 4),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 4),
                      child: SizedBox(
                        width: double.infinity,
                        height: height * 8,
                        child: KadButtom(
                          label:
                              state.isReady
                                  ? 'Parar alerta'
                                  : 'Não é seu pedido?',
                          appearence:
                              state.isReady
                                  ? KadButtonAppearence.primary
                                  : KadButtonAppearence.secondary,
                          fontSize: width * 4,
                          onClick: () {
                            if (state.isReady) {}
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget alertTypeButtom(
    BuildContext context,
    IconData icon,
    String label,
    AlertType type,
  ) {
    final double width = MediaQuery.of(context).size.width / 100;
    final double height = MediaQuery.of(context).size.height / 100;

    final bool isSelected = _controller.value.selectedAlertTypes.contains(type);

    return Column(
      children: [
        InkWell(
          enableFeedback: false,
          //onTap: () => _controller.changedAlertType(type),
          child: CircleAvatar(
            radius: width * 7,
            backgroundColor:
                isSelected ? const Color(0XFF8D34D2) : const Color(0XFFEAF0F5),
            child: Padding(
              padding: EdgeInsets.all(width * 4),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : const Color(0XFF848FAD),
                size: width * 6,
              ),
            ),
          ),
        ),
        SizedBox(height: height * 1.5),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            color:
                isSelected ? const Color(0XFF5B5574) : const Color(0XFF848FAD),
            fontSize: width * 4,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  String get _timer {
    final int countTime = _totalTime - _countTime;

    String minutes = (countTime ~/ 60).toString();
    if (minutes.length == 1) minutes = '0$minutes';

    String seconds = (countTime % 60).toString();
    if (seconds.length == 1) seconds = '0$seconds';

    return '$minutes:$seconds';
  }
}
