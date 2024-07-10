import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';

import '../../timer/timer_container.dart';

class RobotWaveWidget extends HookWidget{
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Lottie.asset('assets/animation/robot_wave.json'),
    );
  }

}