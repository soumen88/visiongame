import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:visiongame/base/constants.dart';
import 'package:visiongame/injector/injection.dart';

import '../base/logger_utils.dart';

class StartListeningWidget extends HookWidget{

  final _logger = locator<LoggerUtils>();
  final _TAG = "StartListeningWidget";

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        child: Align(
          alignment: Alignment.center,
          child: // Load a Lottie animation file from your assets
          Lottie.asset('assets/animation/start_listening.json'),
        )
    );
  }

}