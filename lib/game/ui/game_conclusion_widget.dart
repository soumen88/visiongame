import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:visiongame/injector/injection.dart';
import 'package:visiongame/loading/loading_widget.dart';
import 'package:visiongame/providers/provider.dart';

import '../../base/logger_utils.dart';
import '../../home/start_listening_widget.dart';

class GameConclusionWidget extends HookConsumerWidget{
  final _logger = locator<LoggerUtils>();
  final _TAG = "GameOverWidget";
  bool isBottomSheetDisplayed = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameNotifier = ref.watch(gameProvider.notifier);
    final gameStateProvider = ref.watch(gameProvider);
    final timerNotifier = ref.watch(timerProvider.notifier);
    final displaySheet = useStream(gameNotifier.gameOverbottomSheetNotifier.stream);

    void displayBottomSheet(){
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        context: context,
        barrierColor: Colors.white.withOpacity(0.0),
        builder: (context) {
          return StartListeningWidget();
        },
      );
    }

    if(displaySheet.data != null){
      _logger.log(_TAG, "Display sheet data ${displaySheet.data}");
      if(displaySheet.data == false && isBottomSheetDisplayed){
        Future.delayed(Duration.zero, (){
          Navigator.pop(context);
        });
      }
      else{
        Future.delayed(Duration.zero, (){
          isBottomSheetDisplayed = true;
          timerNotifier.startTimer();
          displayBottomSheet();
        });
      }
    }

    return gameStateProvider.maybeWhen(
        displayGameWin: (){
          return Scaffold(
            backgroundColor: Colors.lightGreen,
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onDoubleTap: (){
                _logger.log(_TAG, "Restart game");
                gameNotifier.reloadBottomSheet(false);
                gameNotifier.restartGame();
              },
              child: SizedBox.expand(
                child: Align(
                  alignment: Alignment.center,
                  child: // Load a Lottie animation file from your assets
                  Lottie.asset('assets/animation/win_animation.json'),
                ),
              ),
            ),
          );
        },
        displayGameOver: (){
          return Scaffold(
            backgroundColor: Colors.lightGreen,
            body: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onDoubleTap: (){
                _logger.log(_TAG, "Restart game");
                gameNotifier.reloadBottomSheet(false);
                gameNotifier.restartGame();
              },
              child: SizedBox.expand(
                child: Align(
                  alignment: Alignment.center,
                  child: // Load a Lottie animation file from your assets
                  Lottie.asset('assets/animation/gameover.json'),
                ),
              ),
            ),
          );
        },
        orElse: (){
          return LoadingWidget();
        }
    );

  }

}