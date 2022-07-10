import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/difficultylevel/model/difficulty_level_view_state.dart';
import 'package:visiongame/injector/injection.dart';

import '../../base/constants.dart';
import '../../base/logger_utils.dart';
import '../../base/speech_input_model.dart';
import '../../enums/speech_input_enums.dart';
import '../../texttospeech/vision_text_to_speech_converter.dart';
import '../../voiceinput/vision_speech_input.dart';

class DifficultyLevelStateNotifier extends StateNotifier<DifficultyLevelViewState>{

  final _logger = locator<LoggerUtils>();
  final _TAG = "DifficultyLevelStateNotifier";

  ///Below variable is used for text to speech
  final visionTts = locator<VisionTextToSpeechConverter>();

  ///Below variable is used for taking speech input from user
  final visionSpeechInput = locator<VisionSpeechInput>();

  ///Below variable will show bottom sheet on the difficulty selection screen
  BehaviorSubject<bool?> difficultyScreenBottomSheetEvent = BehaviorSubject<bool?>.seeded(null);
  BehaviorSubject<String?> startNextScreenEvent = BehaviorSubject<String?>.seeded(null);

  bool isSpeakingComplete = false;

  DifficultyLevelStateNotifier() : super(const DifficultyLevelViewState.loading()){
    listenToSpeechInput();
  }

  ///Below function asks for difficulty level in the game
  Future<bool> askForDifficultyLevel() async{
    state = const DifficultyLevelViewState.homeView();
    bool isSpeechInputInitializationComplete = await visionSpeechInput.setUpVoiceInput();
    if(isSpeechInputInitializationComplete){
      String lineOne = "Nice!";
      bool isSpeakComplete1 = await visionTts.speakText(lineOne);
      String lineTwo = "Now we move to our next part.";
      bool isSpeakComplete2 = await visionTts.speakText(lineTwo);
      /*String lineThree = "What would be the difficulty for this game? You have three choices";
      bool isSpeakComplete3 = await visionTts.speakText(lineThree);
      String lineFour = "Would you want your game to be easy, medium or hard?";
      bool isSpeakComplete4 = await visionTts.speakText(lineFour);
      String lineFive = "Swipe left or say easy";
      bool isSpeakComplete5 = await visionTts.speakText(lineFive);
      String lineSix = "Or Swipe right or say medium";
      bool isSpeakComplete6 = await visionTts.speakText(lineSix);
      String lineSeven = "And you can Swipe up or say hard for selecting hard";
      bool isSpeakComplete7 = await visionTts.speakText(lineSeven);*/
      /*if( isSpeakComplete1 && isSpeakComplete2 && isSpeakComplete3 && isSpeakComplete4 &&
          isSpeakComplete5 && isSpeakComplete6 && isSpeakComplete7 ){*/
      if( isSpeakComplete1 && isSpeakComplete2){
        _logger.log(_TAG, "All speak completed");
        isSpeakingComplete = true;
        reloadDifficultyBottomSheet(true);
        return Future.value(isSpeakingComplete);
      }
    }
    return Future.value(false);
  }

  ///Whatever the user has spoken will be listened here
  void listenToSpeechInput(){
    visionSpeechInput.currentInput.listen((SpeechInputModel? inputModel) {
      _logger.log(_TAG, "Input model $inputModel");
      if(inputModel != null && inputModel.textRecognized.isNotEmpty &&
          inputModel.speechInputEnums == SpeechInputEnums.DIFFICULTY_LEVEL){
        if(inputModel.textRecognized.contains("easy")
            || inputModel.textRecognized.contains("medium")
            || inputModel.textRecognized.contains("hard")){
          _logger.log(_TAG, "Start next game screen");
          startNextScreen(ApplicationConstants.ScreenGame);
        }
      }
    });
  }



  ///When this function is loaded with value as true then bottom sheet is displayed on home screen
  ///for 5 seconds and then closed
  ///For this duration the speech input is also invoked for capturing what user is saying in difficulty screen
  void reloadDifficultyBottomSheet(bool value) async{
    difficultyScreenBottomSheetEvent.add(true);
    _logger.log(_TAG, "Beginning to listen again");
    bool isListening = await visionSpeechInput.startListening(SpeechInputEnums.DIFFICULTY_LEVEL);
    if(isListening){
      Future.delayed(Duration(seconds: ApplicationConstants.kSpeechTimerLimit),() async{
        difficultyScreenBottomSheetEvent.add(false);
        await visionSpeechInput.stopListening();
      });
    }
  }

  void startNextScreen(String value){
    startNextScreenEvent.add(value);
  }
}