import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:visiongame/injector/injection.dart';

import '../loading/loading_widget.dart';
import '../providers/provider.dart';
import '../texttospeech/vision_text_to_speech_converter.dart';

class HomeScreenPage extends HookConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visionTts = locator<VisionTextToSpeechConverter>();
    final homeScreenNotifier = ref.watch(homeScreenProviders.notifier);
    final homeScreenState = ref.watch(homeScreenProviders);

    useEffect((){
      homeScreenNotifier.init();
    }, const []);

    return homeScreenState.maybeWhen(
        homeView: (){
          return Scaffold(
            body: Center(
              child:  // Load a Lottie animation file from your assets
              Lottie.asset('assets/animation/robot_wave.json'),

            ),
          );
        },
        orElse: (){
          return LoadingWidget();
        }
    );
  }

}