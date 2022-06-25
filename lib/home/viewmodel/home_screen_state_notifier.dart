import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visiongame/base/constants.dart';
import 'package:visiongame/injector/injection.dart';

import '../../texttospeech/vision_text_to_speech_converter.dart';
import '../model/home_screen_view_state.dart';

class HomeScreenStateNotifer extends StateNotifier<HomeScreenViewState> {

  final visionTts = locator<VisionTextToSpeechConverter>();
  HomeScreenStateNotifer() : super(const HomeScreenViewState.homeView());

  ///Step 1 - Display the loading animation for displaying hi robot on home screen
  void init() async{
    state = const HomeScreenViewState.homeView();
    Future.delayed(Duration(seconds: 2),(){
      startIntroduction();
    });
  }

  void startIntroduction() async{
    String lineOne = "Hello I am Amaze Robot.";
    await visionTts.speakText(lineOne);
    String lineTwo = "I would be assisting you to play this Amazing game.";
    await visionTts.speakText(lineTwo);
    String lineThree = "To Continue playing, Please speak ready or double tap any where on the screen";
    await visionTts.speakText(lineThree);

  }
}