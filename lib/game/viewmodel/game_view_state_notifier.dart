import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/game/models/game_screen_view_state.dart';
import 'package:visiongame/injector/injection.dart';

import '../../base/constants.dart';
import '../../base/logger_utils.dart';
import '../../base/permission_utils.dart';
import '../../base/speech_input_model.dart';
import '../../enums/player_life_status_enums.dart';
import '../../enums/speech_input_enums.dart';
import '../../texttospeech/vision_text_to_speech_converter.dart';
import '../../voiceinput/vision_speech_input.dart';
import '../models/player_motion_model.dart';
import '../triggers/game_triggers.dart';
import '../triggers/game_tutorial_triggers.dart';

class GameViewStateNotifier extends StateNotifier<GameScreenViewState>{

  final _logger = locator<LoggerUtils>();
  final _TAG = "GameViewStateNotifier";
  final _gameTriggers = locator<GameTriggers>();
  final _gameTutorialTriggers = locator<GameTutorialTriggers>();
  ///Below variable is used for text to speech
  ///
  final _visionTts = locator<VisionTextToSpeechConverter>();

  ///Below variable is used for taking speech input from user
  final visionSpeechInput = locator<VisionSpeechInput>();

  bool isSpeechInputEnabled = false;

  ///Below variable is used for displaying bottom sheet on the game over screen
  BehaviorSubject<bool?> gameOverbottomSheetNotifier = BehaviorSubject<bool?>.seeded(null);

  ///If this flag is passed as true then game will be opened for tutorial view
  bool isTutorialView = false;

  GameViewStateNotifier() : super(const GameScreenViewState.loading());

  void init(){
    _gameTriggers.toggleVoiceInput(isInitial: true);
    if(isTutorialView){
      state = const GameScreenViewState.displayRobotView();
    }
    else{
      state = const GameScreenViewState.displayGameView();
    }
  }

  ///Whenever game would get over or player would win state for widget is set here
  void listenPlayerEvents(){
    _gameTriggers.playerLifeEventNotifier.listen((PlayerMotionModel? playerMotionModel) {
      _logger.log(_TAG, "Notifier player motion model $playerMotionModel");
      if(playerMotionModel != null){
        if(playerMotionModel.event == PlayerLifeStatusEnums.PLAYER_GAME_OVER){
          _logger.log(_TAG, "Player game over");
          _gameTriggers.toggleVoiceInput(stopSpeaking: true);
          state = const  GameScreenViewState.displayGameOver();
        }
        if(playerMotionModel.event == PlayerLifeStatusEnums.PLAYER_GAME_WIN){
          _logger.log(_TAG, "Player game win");
          _gameTriggers.toggleVoiceInput(stopSpeaking: true);
          state = const GameScreenViewState.displayGameWin();
        }
      }
    });
  }

  ///Whatever the user has spoken will be listened here
  void listenToSpeechInput(){
    if(isSpeechInputEnabled){
      visionSpeechInput.currentInput.listen((SpeechInputModel? inputModel) {
        _logger.log(_TAG, "Input model $inputModel");
        if(inputModel != null && inputModel.textRecognized.isNotEmpty &&
            inputModel.speechInputEnums == SpeechInputEnums.RESTART_GAME){
          if(inputModel.textRecognized.contains("yes")){
            _logger.log(_TAG, "Restart game event received");
            restartGame();
            reloadBottomSheet(false);
          }
        }
      });
    }

  }


  void startGameOverScript() async{
    _logger.log(_TAG, "Inside game over script");
    if(isSpeechInputEnabled){
      PermissionUtils permissionUtils = PermissionUtils();
      bool isPermissionGranted = await permissionUtils.askMicroPhonePermission();
    }
    await _visionTts.speakStop();
    String lineOne = "Alas, that was bad. We hope that you liked our game";
    bool isSpeakOneComplete = await _visionTts.speakText(lineOne);
    String lineTwo = "Do you want to continue playing our game?";
    bool isSpeakTwoComplete = await _visionTts.speakText(lineTwo);

    String linethree;
    if(isSpeechInputEnabled){
      linethree = "Say yes to continue or double tap on the screen";
    }
    else{
      linethree = "Double tap on the screen";
    }

    bool isSpeakThreeComplete = await _visionTts.speakText(linethree);
    if(isSpeakOneComplete && isSpeakTwoComplete && isSpeakThreeComplete){
      reloadBottomSheet(true);
    }
  }

  void startGameWinScript() async{
    if(isSpeechInputEnabled){
      PermissionUtils permissionUtils = PermissionUtils();
      bool isPermissionGranted = await permissionUtils.askMicroPhonePermission();
      _logger.log(_TAG, "Inside game win script");
      if(isPermissionGranted){

      }
    }
    await _visionTts.speakStop();
    String lineOne = "Congratulations on winning this game. You have successfully saved ${ApplicationConstants.PlayerName} life";
    bool isLineOneComplete = await _visionTts.speakText(lineOne);
    String lineTwo = "We hope that you liked our game";
    bool isLineTwoComplete = await _visionTts.speakText(lineTwo);
    String lineThree = "Do you want to continue playing our game?";
    bool isLineThreeComplete = await _visionTts.speakText(lineThree);
    String lineFour;
    if(isSpeechInputEnabled){
      lineFour = "Say yes to continue or double tap on the screen";
    }
    else{
      lineFour = "double tap on the screen";
    }

    bool isLineFourComplete = await _visionTts.speakText(lineFour);
    if(isLineOneComplete && isLineTwoComplete && isLineThreeComplete & isLineFourComplete){
      reloadBottomSheet(true);
    }
  }

  ///When this function is loaded with value as true then bottom sheet is displayed on home screen
  ///for 5 seconds and then closed
  ///For this duration the speech input is also invoked for capturing what user is saying
  void reloadBottomSheet(bool value) async{
    if(value){
      gameOverbottomSheetNotifier.add(true);
      if(isSpeechInputEnabled){
        bool isListening = await visionSpeechInput.startListening(SpeechInputEnums.RESTART_GAME);
        if(isListening){
          Future.delayed(Duration(seconds: ApplicationConstants.kSpeechTimerLimit),() async{
            if(visionSpeechInput.isSpeechEnabled){
              gameOverbottomSheetNotifier.add(false);
              await visionSpeechInput.stopListening();
            }
          });
        }
      }
      else{
        gameOverbottomSheetNotifier.add(false);
      }
    }
    else{
      gameOverbottomSheetNotifier.add(false);
      await _visionTts.speakStop();
      if(visionSpeechInput.isSpeechEnabled){
        await visionSpeechInput.stopListening();
      }
    }
  }

  void listenToGameSteps(){
    _gameTutorialTriggers.stepCounter.listen((int? stepValue) {
      if(stepValue != null){
        switch(stepValue){
          case 1:{
            state = const GameScreenViewState.displayTutorialView();
          }
          break;
          case 2:{
            startStepTwoInTutorial();
          }
          break;
          case 4:{
            startStepThreeInTutorial();
          }
          break;
          case 5:{
            startStepFourInTutorial();
          }
          break;
          case 6:{
            startStepFiveInTutorial();
          }
          break;
          default:{
            break;
          }
        }
      }
    });
  }

  Future<bool> startStepOneInTutorial() async{
    String lineOne = "Nice. Now Amaze would let you know how to play this game.";
    bool isLineOneComplete = await _visionTts.speakText(lineOne);
    String lineTwo = "In a moment I will show you our game";
    bool isLineTwoComplete = await _visionTts.speakText(lineTwo);
    String lineThree = "At center of screen you will see our game hero and his name is ${ApplicationConstants.PlayerName}";
    bool isLineThreeComplete = await _visionTts.speakText(lineThree);
    String lineFour = "Now swipe left to see ${ApplicationConstants.PlayerName} walking";
    bool isLineFourComplete = await _visionTts.speakText(lineFour);
    bool isAllComplete = isLineOneComplete && isLineTwoComplete && isLineThreeComplete && isLineFourComplete;
    if(isAllComplete){
      _gameTutorialTriggers.addStepCounter(1);
    }
    return Future.value(isAllComplete);
  }

  void startStepTwoInTutorial() async{
    String lineOne = "Now lets move on to Step Two.";
    bool isLineOneComplete = await _visionTts.speakText(lineOne);
    String lineTwo = "Amaze will now introduce you to game collectables.";
    bool isLineTwoComplete = await _visionTts.speakText(lineTwo);
    String lineThree = "In your screen you will now see a coin.";
    bool isLineThreeComplete = await _visionTts.speakText(lineThree);
    String lineFour = "Swipe on your screen and make ${ApplicationConstants.PlayerName} walk over coin to collect it";
    bool isLineFourComplete = await _visionTts.speakText(lineFour);
    bool isAllComplete = isLineOneComplete && isLineTwoComplete && isLineThreeComplete && isLineFourComplete;
    if(isAllComplete){
      _gameTutorialTriggers.addStepCounter(3);
    }
  }

  void startStepThreeInTutorial() async{
    String lineOne = "In a similar way you will also see other collectibles in the game";
    bool isLineOneComplete = await _visionTts.speakText(lineOne);
    /*String lineTwo = "When ${ApplicationConstants.PlayerName} collects a heart he would have more lives to fight";
    bool isLineTwoComplete = await _visionTts.speakText(lineTwo);*/
    //bool isComplete = isLineOneComplete && isLineTwoComplete;
    bool isComplete = isLineOneComplete;
    if(isComplete){
      _gameTutorialTriggers.addStepCounter(5);
    }
  }

  void startStepFourInTutorial() async{
    String lineOne = "Well as you know every story has a villain";
    bool isLineOneComplete = await _visionTts.speakText(lineOne);
    String lineTwo = "In this game villain is a group of monsters";
    bool isLineTwoComplete = await _visionTts.speakText(lineTwo);
    String lineThree = "In a moment you will see a monster";
    bool isLineThreeComplete = await _visionTts.speakText(lineThree);
    String lineFour = "${ApplicationConstants.PlayerName} has to avoid coming in contact with this monsters to save his life.";
    bool isLineFourComplete = await _visionTts.speakText(lineFour);
    bool isComplete = isLineOneComplete && isLineTwoComplete && isLineThreeComplete && isLineFourComplete;
    if(isComplete){
      _gameTutorialTriggers.addStepCounter(6);
    }

  }

  void startStepFiveInTutorial() async{
    String lineOne = "Now I am going to take you to our Actual game";
    bool isLineOneComplete = await _visionTts.speakText(lineOne);
    String lineTwo = "I believe you would love to play it";
    bool isLineTwoComplete = await _visionTts.speakText(lineTwo);
    bool isAllComplete = isLineOneComplete && isLineTwoComplete;
    _gameTutorialTriggers.setTutorialInProgress(false);
    if(isAllComplete){
      state = GameScreenViewState.displayGameView();
    }
  }

  void setTutorialView(bool value){
    isTutorialView = value;
  }

  void restartGame(){
    _gameTriggers.resetGame();
    _gameTriggers.toggleVoiceInput(isInitial: true);
    state = const GameScreenViewState.displayGameView();
  }

}