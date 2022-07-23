import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/difficultylevel/model/difficulty_level_view_state.dart';
import 'package:visiongame/injector/injection.dart';

import '../../base/constants.dart';
import '../../base/logger_utils.dart';
import '../../base/speech_input_model.dart';
import '../../enums/difficulty_level_enum.dart';
import '../../enums/speech_input_enums.dart';
import '../../game/triggers/game_triggers.dart';
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

  ///Once tutorial function is in progress this variable is made true
  bool isReadingTutorial = false;

  final _gameTriggers = locator<GameTriggers>();

  DifficultyLevelStateNotifier() : super(const DifficultyLevelViewState.loading()){
    listenToSpeechInput();
  }

  ///Below function asks for difficulty level in the game
  Future<bool> askForDifficultyLevel() async{
    state = const DifficultyLevelViewState.homeView();
    bool isSpeechInputInitializationComplete = await visionSpeechInput.setUpVoiceInput();
    if(isSpeechInputInitializationComplete){
      //reloadDifficultyBottomSheet(true);
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
      if( isSpeakComplete1 && isSpeakComplete2){
      /*if( isSpeakComplete1 && isSpeakComplete2 && isSpeakComplete3 && isSpeakComplete4 &&
          isSpeakComplete5 && isSpeakComplete6 && isSpeakComplete7 ){*/
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

        if(inputModel.textRecognized.contains("easy")){
          //_gameTriggers.setDifficultyLevel(DifficultyLevelEnums.EASY);
          
        }
        else if(inputModel.textRecognized.contains("medium")){
          //_gameTriggers.setDifficultyLevel(DifficultyLevelEnums.MEDIUM);
        }
        else if(inputModel.textRecognized.contains("hard")){
          //_gameTriggers.setDifficultyLevel(DifficultyLevelEnums.MEDIUM);
        }

        

      }
    });
  }

  ///When this function is loaded with value as true then bottom sheet is displayed on home screen
  ///for 5 seconds and then closed
  ///For this duration the speech input is also invoked for capturing what user is saying in difficulty screen
  void reloadDifficultyBottomSheet(bool value) async{
    if(value){
      difficultyScreenBottomSheetEvent.add(true);
      _logger.log(_TAG, "Beginning to listen again");
      bool isListening = await visionSpeechInput.startListening(SpeechInputEnums.DIFFICULTY_LEVEL);
      if(isListening){
        Future.delayed(Duration(seconds: ApplicationConstants.kSpeechTimerLimit),() async{
          if(visionSpeechInput.isSpeechEnabled){
            difficultyScreenBottomSheetEvent.add(false);
            await visionSpeechInput.stopListening();
          }
        });
      }
    }
    else{
      await visionTts.speakStop();
      difficultyScreenBottomSheetEvent.add(false);
      if(visionSpeechInput.isSpeechEnabled){
        await visionSpeechInput.stopListening();
      }

    }
  }

  void startNextScreen(String value){
    startNextScreenEvent.add(value);
  }
  
  Future<bool> displayDifficulty() async{
    bool isDifficultyDisplayedSpeakingComplete = false;
    state = DifficultyLevelViewState.displayLevel();
    String lineOne = "";
    return Future.value(isDifficultyDisplayedSpeakingComplete);
  }

  ///Below function would read tutorial for player for understanding this game
  Future<bool> readTutorial() async{
    //state = DifficultyLevelViewState.readTutorial();
    isReadingTutorial = true;
    String lineOne = "Now Amaze would let you know about instructions for playing this game.";
    bool isLineOneComplete = await visionTts.speakText(lineOne);
    String lineTwo = "Our Hero ${ApplicationConstants.PlayerName}, has been trapped.";
    bool isLineTwoComplete = await visionTts.speakText(lineTwo);
    String lineThree = "And to get out of this trap ${ApplicationConstants.PlayerName} has to collect coins.";
    bool isLineThreeComplete = await visionTts.speakText(lineThree);
    String lineFour = "Well, this is not easy as ${ApplicationConstants.PlayerName} would be meeting a Ghost.";
    bool isLineFourComplete = await visionTts.speakText(lineFour);
    String lineFive = "You have to save ${ApplicationConstants.PlayerName} by collecting ${ApplicationConstants.kLevelEasyCompletionCoins} coins.";
    bool isLineFiveComplete = await visionTts.speakText(lineFive);
    String lineSix = "You can move ${ApplicationConstants.PlayerName} by Swiping left, right, up and down in order to collect coins.";
    bool isLineSixComplete = await visionTts.speakText(lineSix);
    String lineSeven = "Do not forget to collect hearts to Save ${ApplicationConstants.PlayerName}'s life from Angry Monster.";
    bool isLineSevenComplete = await visionTts.speakText(lineSeven);
    String lineEight = "Swipe Right to Continue or swipe left to read the instructions again.";
    bool isLineEightComplete = await visionTts.speakText(lineEight);
    if(isLineOneComplete && isLineTwoComplete && isLineThreeComplete && isLineFourComplete &&
        isLineFiveComplete && isLineSixComplete && isLineSevenComplete && isLineEightComplete){
      isReadingTutorial = false;
    }
    return Future.value(isReadingTutorial);
  }
}