import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/difficultylevel/model/difficulty_level_view_state.dart';
import 'package:visiongame/generated/locale_keys.g.dart';
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
  //final visionSpeechInput = locator<VisionSpeechInput>();

  ///Below variable will show bottom sheet on the difficulty selection screen
  BehaviorSubject<bool?> difficultyScreenBottomSheetEvent = BehaviorSubject<bool?>.seeded(null);
  BehaviorSubject<String?> startNextScreenEvent = BehaviorSubject<String?>.seeded(null);

  bool isSpeakingComplete = false;

  ///Once tutorial function is in progress this variable is made true
  bool isReadingTutorial = false;

  final _gameTriggers = locator<GameTriggers>();

  DifficultyLevelStateNotifier() : super(const DifficultyLevelViewState.loading());
  ///Below function asks for difficulty level in the game
  Future<bool> askForDifficultyLevel() async{

    state = const DifficultyLevelViewState.homeView();
    //await visionTts.speakStop();
    visionTts.enableSpeaking();
    String lineOne = LocaleKeys.difficulty_level_ask_for_difficulty_level_line_one.tr();
    bool isSpeakComplete1 = await visionTts.speakText(lineOne);
    String lineTwo = LocaleKeys.difficulty_level_ask_for_difficulty_level_line_two.tr();
    bool isSpeakComplete2 = await visionTts.speakText(lineTwo);
    String lineThree = LocaleKeys.difficulty_level_ask_for_difficulty_level_line_three.tr();
    bool isSpeakComplete3 = await visionTts.speakText(lineThree);
    String lineFour = LocaleKeys.difficulty_level_ask_for_difficulty_level_line_four.tr();
    bool isSpeakComplete4 = await visionTts.speakText(lineFour);
    String lineFive = LocaleKeys.difficulty_level_ask_for_difficulty_level_line_five.tr();
    bool isSpeakComplete5 = await visionTts.speakText(lineFive);
    //if( isSpeakComplete1 && isSpeakComplete2){
    if( isSpeakComplete1 && isSpeakComplete2 && isSpeakComplete3 && isSpeakComplete4 && isSpeakComplete5){
      _logger.log(_TAG, "All speak completed");
      isSpeakingComplete = true;
      //reloadDifficultyBottomSheet(true);
      return Future.value(isSpeakingComplete);
    }
    return Future.value(false);
  }


  Future<void> stopSpeaking() async{
    await visionTts.speakStop();
  }

  void startNextScreen(String value){
    startNextScreenEvent.add(value);
  }


  ///Below function would read tutorial for player for understanding this game
  Future<bool> readGameInstructions() async{
    state = const DifficultyLevelViewState.startGameView();
    isReadingTutorial = true;
    //await visionTts.speakStop();
    visionTts.enableSpeaking();
    String lineOne = LocaleKeys.difficulty_level_read_game_instructions_line_one.tr(namedArgs: {
      'appName' : ApplicationConstants.APP_NAME
    });
    bool isLineOneComplete = await visionTts.speakText(lineOne);
    String lineTwo = LocaleKeys.difficulty_level_read_game_instructions_line_two.tr(namedArgs: {
      'playerName' : ApplicationConstants.PlayerName
    });
    bool isLineTwoComplete = await visionTts.speakText(lineTwo);
    String lineThree = LocaleKeys.difficulty_level_read_game_instructions_line_three.tr(namedArgs: {
      'playerName' : ApplicationConstants.PlayerName
    });
    bool isLineThreeComplete = await visionTts.speakText(lineThree);
    String lineFour = LocaleKeys.difficulty_level_read_game_instructions_line_four.tr(namedArgs: {
      'playerName' : ApplicationConstants.PlayerName
    });
    bool isLineFourComplete = await visionTts.speakText(lineFour);
    String lineFive = LocaleKeys.difficulty_level_read_game_instructions_line_five.tr(namedArgs: {
      'playerName' : ApplicationConstants.PlayerName,
      'kLevelEasyCompletionCoins' : ApplicationConstants.kLevelEasyCompletionCoins.toString(),
    });
    bool isLineFiveComplete = await visionTts.speakText(lineFive);
    String lineSix = LocaleKeys.difficulty_level_read_game_instructions_line_six.tr(namedArgs: {
      'playerName' : ApplicationConstants.PlayerName
    });
    bool isLineSixComplete = await visionTts.speakText(lineSix);
    String lineSeven = LocaleKeys.difficulty_level_read_game_instructions_line_seven.tr(namedArgs: {
      'playerName' : ApplicationConstants.PlayerName
    });
    bool isLineSevenComplete = await visionTts.speakText(lineSeven);
    /*String lineEight = "Swipe Right to Continue or swipe left to read the instructions again.";
    bool isLineEightComplete = await visionTts.speakText(lineEight);*/

    isReadingTutorial = false;
    if(isLineOneComplete && isLineTwoComplete && isLineThreeComplete && isLineFourComplete &&
        isLineFiveComplete && isLineSixComplete && isLineSevenComplete){
      startNextScreen(ApplicationConstants.ScreenGame);
      _logger.log(_TAG, "All speak complete start new screen");
    }
    return Future.value(isReadingTutorial);
  }
}