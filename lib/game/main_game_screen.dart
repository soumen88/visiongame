import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visiongame/game/helpers/swipe_detector.dart';
import 'package:visiongame/injector/injection.dart';
import '../base/logger_utils.dart';
import 'helpers/joypad.dart';
import 'vision_game.dart';

class MainGamePage extends HookConsumerWidget {
  final _logger = locator<LoggerUtils>();
  final _TAG = "MainGamePage";
  VisionGame game = VisionGame();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
        body: SwipeDetector(
          onSwipeDown: (Offset offset){
            _logger.log(_TAG, "Swipe down");
          },
          onSwipeLeft: (Offset offset){
            _logger.log(_TAG, "Swipe left");
          },
          onSwipeRight: (Offset offset){
            _logger.log(_TAG, "Swipe right");
          },
          onSwipeUp: (Offset offset){
            _logger.log(_TAG, "Swipe up");
          },
          child: Stack(
            children: [
              GameWidget(game: game),
            ],
          ),
        )
    );
  }

}
