import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visiongame/base/empty_widget.dart';
import 'package:visiongame/game/helpers/direction.dart';
import 'package:visiongame/game/helpers/swipe_detector.dart';
import 'package:visiongame/game/triggers/game_tutorial_triggers.dart';
import 'package:visiongame/game/ui/game_conclusion_widget.dart';
import 'package:visiongame/game/ui/game_tracker_widget.dart';
import 'package:visiongame/game/ui/game_volume_widget.dart';
import 'package:visiongame/home/viewmodel/robot_wave_widget.dart';
import 'package:visiongame/injector/injection.dart';
import 'package:visiongame/tutorial/tutorial_game.dart';
import '../base/logger_utils.dart';
import '../loading/loading_widget.dart';
import '../providers/provider.dart';
import 'vision_game.dart';

class MainGamePage extends HookConsumerWidget {
  final _logger = locator<LoggerUtils>();
  final _TAG = "MainGamePage";
  final _gameTutorialTrigger = locator<GameTutorialTriggers>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final gameProviderState = ref.watch(gameProvider);
    final gameNotifier = ref.watch(gameProvider.notifier);


    useEffect(() {
      _logger.log(_TAG, "Inside use effect");
      Future.delayed(Duration.zero, () async{
        _logger.log(_TAG, "Starting game view");
        gameNotifier.init();
      });
    }, const []);

    gameProviderState.whenOrNull(
        displayRobotView: () async{
          ///Starting tutorial with step one
          _gameTutorialTrigger.setTutorialInProgress(true);
          gameNotifier.listenToGameSteps();
          bool isStepComplete = await gameNotifier.startStepOneInTutorial();
        },
        displayGameWin: (){
          gameNotifier.startGameWinScript();
        },
        displayGameOver: (){
          gameNotifier.startGameOverScript();
        }
    );

    return gameProviderState.maybeWhen(
        displayGameOver: (){
          _logger.log(_TAG, "Displaying game over view");
          return GameConclusionWidget();
        },
        displayGameWin: (){
          _logger.log(_TAG, "Displaying game over view");
          return GameConclusionWidget();
        },
        displayGameView: (){
          VisionGame game = VisionGame(screenWidth: width.toInt(), screenHeight: height.toInt());
          gameNotifier.listenPlayerEvents();
          gameNotifier.listenToSpeechInput();
          return Scaffold(
              backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
              body: SwipeDetector(
                onSwipeDown: (Offset offset){
                  //_logger.log(_TAG, "Swipe down");
                  game.onArrowKeyChanged(Direction.down);
                },
                onSwipeLeft: (Offset offset){
                  //_logger.log(_TAG, "Swipe left");
                  game.onArrowKeyChanged(Direction.left);
                },
                onSwipeRight: (Offset offset){
                  //_logger.log(_TAG, "Swipe right");
                  game.onArrowKeyChanged(Direction.right);
                },
                onSwipeUp: (Offset offset){
                  //_logger.log(_TAG, "Swipe up");
                  game.onArrowKeyChanged(Direction.up);
                },
                child: Stack(
                  children: [
                    GameWidget(game: game),
                    /*Positioned(
                      top: 100,
                      left: 100,
                      child: ElevatedButton(onPressed: () async{
                        _logger.log(_TAG, "Test button was clicked");
                          game.check();
                      }, child: Text("Test")),
                    ),*/
                    GameTrackerWidget(),
                    GameVolumeWidget()
                  ],
                ),
              )
          );
        },
        displayTutorialView: (){
          TutorialGame tutorialGame = TutorialGame(screenWidth: width.toInt(), screenHeight: height.toInt());
          return Scaffold(
              backgroundColor: const Color.fromRGBO(0, 0, 0, 1),
              body: SwipeDetector(
                onSwipeDown: (Offset offset){
                  //_logger.log(_TAG, "Swipe down");
                  tutorialGame.onArrowKeyChanged(Direction.down);
                },
                onSwipeLeft: (Offset offset){
                  //_logger.log(_TAG, "Swipe left");
                  tutorialGame.onArrowKeyChanged(Direction.left);
                },
                onSwipeRight: (Offset offset){
                  //_logger.log(_TAG, "Swipe right");
                  tutorialGame.onArrowKeyChanged(Direction.right);
                },
                onSwipeUp: (Offset offset){
                  //_logger.log(_TAG, "Swipe up");
                  tutorialGame.onArrowKeyChanged(Direction.up);
                },
                child: GameWidget(game: tutorialGame),
              )
          );
        },
        displayRobotView: (){
          return Scaffold(
            body: RobotWaveWidget(),
          );
        },
        loading: (){
          _logger.log(_TAG, "Displaying game loading view");
          return LoadingWidget();
        },
        orElse: (){
          return EmptyWidget();
        }
    );

  }

}
