import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:visiongame/enums/difficulty_level_enum.dart';
import 'package:visiongame/loading/loading_widget.dart';
import 'package:visiongame/providers/provider.dart';
import 'package:visiongame/router/app_router.dart';

import '../base/constants.dart';
import '../base/logger_utils.dart';
import '../game/helpers/swipe_detector.dart';
import '../game/triggers/game_triggers.dart';
import '../game/ui/game_tracker_widget.dart';
import '../home/start_listening_widget.dart';
import '../home/viewmodel/robot_wave_widget.dart';
import '../injector/injection.dart';
import 'display_lottie_animation.dart';

@RoutePage()
class DifficultyLevelScreen extends HookConsumerWidget{

  final _logger = locator<LoggerUtils>();
  final _TAG = "DifficultyLevel";
  bool isBottomSheetDisplayed = false;
  final _gameTriggers = locator<GameTriggers>();
  bool isSwipeDone = false;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final difficultyScreenNotifier = ref.watch(difficultyScreenProviders.notifier);
    final difficultyScreenState = ref.watch(difficultyScreenProviders);
    final gameNotifier = ref.watch(gameProvider.notifier);
    final startNextScreen = useStream(difficultyScreenNotifier.startNextScreenEvent.stream);

    useEffect((){
      if(difficultyScreenNotifier.isSpeakingComplete == false){
        Future.delayed(Duration.zero, () async{
          bool isSpeakingComplete = await difficultyScreenNotifier.askForDifficultyLevel();
          if(isSpeakingComplete){
            _logger.log(_TAG, "Speaking is complete now");
          }
        });
      }
    }, const []);


    if(startNextScreen.data != null && startNextScreen.data == ApplicationConstants.ScreenGame){
      _logger.log(_TAG, "Start next screen now");
      context.router.replace(const MainGameRoute());
    }

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

    return difficultyScreenState.maybeWhen(
        homeView: (){
          return Scaffold(
            backgroundColor: Colors.lightGreen,
            body: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DisplayLottieAnimation(lottieFilePath: "assets/animation/swipe_left.json",label: "Swipe Left \n Tutorial",),
                    DisplayLottieAnimation(lottieFilePath: "assets/animation/swipe_right.json",label: "Swipe Right \n Start Game",),
                  ],
                ),
                Expanded(
                    child: SwipeDetector(
                      behavior: HitTestBehavior.opaque,
                      //Start tutorial
                      onSwipeLeft: (Offset offset) async{
                        _logger.log(_TAG, "Swipe left");
                        isSwipeDone = true;
                        gameNotifier.isTutorialView = true;
                        await difficultyScreenNotifier.stopSpeaking();
                        difficultyScreenNotifier.startNextScreen(ApplicationConstants.ScreenGame);
                      },
                      //Begin a fresh game
                      onSwipeRight: (Offset offset) async{
                        _logger.log(_TAG, "Swipe right");
                        isSwipeDone = true;
                        gameNotifier.isTutorialView = false;
                        await difficultyScreenNotifier.stopSpeaking();
                        difficultyScreenNotifier.readGameInstructions();

                      },
                      child: RobotWaveWidget(),
                    ),
                )
              ],
            )
          );
        },
        startGameView: (){
          return Scaffold(
              backgroundColor: Colors.lightGreen,
              body: Center(
                child: RobotWaveWidget(),
              )
          );
        },
        orElse: (){
          return LoadingWidget();
        }
    );

  }
}