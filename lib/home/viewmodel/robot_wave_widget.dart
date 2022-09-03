import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

import '../../timer/timer_container.dart';

class RobotWaveWidget extends HookWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          child: TimerContainer(timerLabel: "Secs", durationLabel: "00",),
        ),
        Align(
          alignment: Alignment.center,
          child: // Load a Lottie animation file from your assets
          Lottie.asset('assets/animation/robot_wave.json'),
        )

      ],
    );
  }

}