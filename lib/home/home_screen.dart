import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:visiongame/enums/speech_input_enums.dart';
import 'package:visiongame/error/error_screen.dart';
import 'package:visiongame/home/start_listening_widget.dart';
import 'package:visiongame/home/viewmodel/robot_wave_widget.dart';
import 'package:visiongame/injector/injection.dart';
import 'package:visiongame/timer/timer_container.dart';

import '../audioplayer/game_audio_player.dart';
import '../base/constants.dart';
import '../base/logger_utils.dart';
import '../loading/loading_widget.dart';
import '../providers/provider.dart';
import '../router/app_router.gr.dart';
import '../texttospeech/vision_text_to_speech_converter.dart';
import '../voiceinput/vision_speech_input.dart';

class HomeScreenPage extends HookConsumerWidget{

  final _logger = locator<LoggerUtils>();
  final _TAG = "HomeScreenPage";
  bool isBottomSheetDisplayed = false;
  //final _visionSpeechInput = locator<VisionSpeechInput>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeScreenNotifier = ref.watch(homeScreenProviders.notifier);
    final timerNotifier = ref.watch(timerProvider.notifier);
    final homeScreenState = ref.watch(homeScreenProviders);
    final displaySheet = useStream(homeScreenNotifier.bottomSheetEvent.stream);
    final startNextScreen = useStream(homeScreenNotifier.startNextScreenEvent.stream);

    useEffect((){
      Future.delayed(Duration.zero, (){
        homeScreenNotifier.init();
      });

    }, const []);

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

    ///When display sheet data is true then bottom sheet is displayed and when it is false it gets
    ///hidden
    if(displaySheet.data != null){
      if(displaySheet.data == false && isBottomSheetDisplayed){
        _logger.log(_TAG, "Closing bottom sheet");
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

    if(startNextScreen.data != null && startNextScreen.data == ApplicationConstants.ScreenDifficulty){
      _logger.log(_TAG, "Start next screen now");
      context.router.replace(const DifficultyLevelScreen());
    }


    return homeScreenState.maybeWhen(
        homeView: (){
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onDoubleTap: (){
              _logger.log(_TAG, 'Double tap event received');
              timerNotifier.hideTimerView();
              homeScreenNotifier.reloadBottomSheet(false);
              homeScreenNotifier.startNextScreen(ApplicationConstants.ScreenDifficulty);
            },
            child: Scaffold(
              backgroundColor: Colors.lightGreen,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*Container(
                    margin: EdgeInsets.all(50),
                    child: ElevatedButton(onPressed: () async{

                    }, child: Text("Test audio")),
                  ),*/
                  RobotWaveWidget()
                ],
              )
            ),
          );
        },
        permissionDeniedView: (){
          return ErrorScreen(errorMessage: ApplicationConstants.PermissionDeniedMessage);
        },
        orElse: (){
          return LoadingWidget();
        }
    );
  }

}