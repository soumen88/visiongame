import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visiongame/game/helpers/direction.dart';
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
            game.onArrowKeyChanged(Direction.down);
          },
          onSwipeLeft: (Offset offset){
            _logger.log(_TAG, "Swipe left");
            game.onArrowKeyChanged(Direction.left);
          },
          onSwipeRight: (Offset offset){
            _logger.log(_TAG, "Swipe right");
            game.onArrowKeyChanged(Direction.right);
          },
          onSwipeUp: (Offset offset){
            _logger.log(_TAG, "Swipe up");
            game.onArrowKeyChanged(Direction.up);
          },
          /*onSwipe: (SwipeDirection swipeDirection, Offset offset){

          },*/
          child: Stack(
            children: [
              GameWidget(game: game),
              Positioned(
                top: 100,
                left: 100,
                child: ElevatedButton(onPressed: (){
                  var player = game.getPlayer;
                  _logger.log(_TAG, "Player current position ${player.position}");
                }, child: Text("Test")),
              )
            ],
          ),
        )
    );
  }

}
