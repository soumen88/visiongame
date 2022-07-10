import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:visiongame/loading/loading_widget.dart';
import 'package:visiongame/providers/provider.dart';
import 'package:visiongame/router/app_router.gr.dart';

import '../base/constants.dart';
import '../base/logger_utils.dart';
import '../game/helpers/swipe_detector.dart';
import '../home/start_listening_widget.dart';
import '../home/viewmodel/robot_wave_widget.dart';
import '../injector/injection.dart';

class DifficultyLevelScreen extends HookConsumerWidget{

  final _logger = locator<LoggerUtils>();
  final _TAG = "DifficultyLevel";
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final difficultyScreenNotifier = ref.watch(difficultyScreenProviders.notifier);
    final difficultyScreenState = ref.watch(difficultyScreenProviders);
    final timerNotifier = ref.watch(timerProvider.notifier);
    final displaySheet = useStream(difficultyScreenNotifier.difficultyScreenBottomSheetEvent.stream);
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
      context.router.replace(MainGameRoute());
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

    if(displaySheet.data != null){
      _logger.log(_TAG, "Bottom sheet data ${displaySheet.data}");
      if(displaySheet.data == false){
        Future.delayed(Duration.zero, (){
          Navigator.pop(context);
        });
      }
      else{
        Future.delayed(Duration.zero, (){
          timerNotifier.startTimer();
          displayBottomSheet();
        });
      }
    }

    return difficultyScreenState.maybeWhen(
        homeView: (){
          return Scaffold(
            body: SizedBox.expand(
              child: SwipeDetector(
                behavior: HitTestBehavior.opaque,
                onSwipeDown: (Offset offset){
                  _logger.log(_TAG, "Swipe down");

                },
                onSwipeLeft: (Offset offset){
                  _logger.log(_TAG, "Swipe left");
                  difficultyScreenNotifier.startNextScreen(ApplicationConstants.ScreenGame);
                },
                onSwipeRight: (Offset offset){
                  _logger.log(_TAG, "Swipe right");
                  difficultyScreenNotifier.startNextScreen(ApplicationConstants.ScreenGame);
                },
                onSwipeUp: (Offset offset){
                  _logger.log(_TAG, "Swipe up");
                  difficultyScreenNotifier.startNextScreen(ApplicationConstants.ScreenGame);
                },
                child: RobotWaveWidget(),
              ),
            )
          );
        },
        orElse: (){
          return LoadingWidget();
        }
    );

  }
}