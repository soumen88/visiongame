import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:visiongame/enums/speech_input_enums.dart';
import 'package:visiongame/home/start_listening_widget.dart';
import 'package:visiongame/home/viewmodel/robot_wave_widget.dart';
import 'package:visiongame/injector/injection.dart';
import 'package:visiongame/timer/timer_container.dart';

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
  final _visionTts = locator<VisionSpeechInput>();
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

    if(displaySheet.data != null){
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

    if(startNextScreen.data != null && startNextScreen.data == ApplicationConstants.ScreenDifficulty){
      _logger.log(_TAG, "Start next screen now");
      context.router.replace(DifficultyLevelScreen());
    }


    return homeScreenState.maybeWhen(
        homeView: (){
          return GestureDetector(
            onDoubleTap: (){
              _logger.log(_TAG, 'Double tap event received');
              homeScreenNotifier.startNextScreen(ApplicationConstants.ScreenDifficulty);
            },
            child: Scaffold(
              backgroundColor: Colors.lightGreen,
              body: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    child: ElevatedButton(onPressed: (){
                      _logger.log(_TAG, "Check if listening");
                      _visionTts.checkIfListening();
                    }, child: Text("Test")),
                  ),
                  RobotWaveWidget()
                ],
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