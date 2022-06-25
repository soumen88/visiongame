import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:visiongame/injector/injection.dart';
import 'package:visiongame/timer/timer_container.dart';

import '../base/logger_utils.dart';
import '../loading/loading_widget.dart';
import '../providers/provider.dart';
import '../texttospeech/vision_text_to_speech_converter.dart';

class HomeScreenPage extends HookConsumerWidget{

  final _logger = locator<LoggerUtils>();
  final _TAG = "HomeScreenPage";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visionTts = locator<VisionTextToSpeechConverter>();
    final homeScreenNotifier = ref.watch(homeScreenProviders.notifier);
    final timerNotifier = ref.watch(timerProvider.notifier);
    final homeScreenState = ref.watch(homeScreenProviders);
    //final isLoading = useState(true);

    useEffect((){
      Future.delayed(Duration.zero, (){
        homeScreenNotifier.init();
        timerNotifier.startTimer();
      });

    }, const []);

    return homeScreenState.maybeWhen(
        homeView: (){
          return GestureDetector(
            onDoubleTap: (){
              _logger.log(_TAG, 'Double tap event received');
            },
            child: Scaffold(
              body: Stack(
                children: [
                  Positioned(
                    top: 50,
                    child: Container(
                      width: 100,
                      height: 100,
                      child: TimerContainer(timerLabel: "Secs", durationLabel: "00",),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: // Load a Lottie animation file from your assets
                    Lottie.asset('assets/animation/robot_wave.json'),
                  )

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