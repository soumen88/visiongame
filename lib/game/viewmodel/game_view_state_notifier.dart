import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/enums/tutorial_step_enums.dart';
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

  //GameViewStateNotifier() : super(const GameScreenViewState.loading());
  GameViewStateNotifier() : super(const GameScreenViewState.loading()){
    listenPlayerEvents();
    listenToSpeechInput();
  }

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
    String lineTwo = "To continue playing our game double tap on the screen";
    bool isSpeakTwoComplete = await _visionTts.speakText(lineTwo);

    /*String linethree;
    if(isSpeechInputEnabled){
      linethree = "Say yes to continue or double tap on the screen";
    }
    else{
      linethree = "Double tap on the screen";
    }
    */
    if(isSpeakOneComplete && isSpeakTwoComplete){
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
    _gameTutorialTriggers.stepCounter.listen((TutorialStepEnums? stepValue) {
      if(stepValue != null){
        switch(stepValue){
          case TutorialStepEnums.START_TUTORIAL_VIEW:{
            state = const GameScreenViewState.displayTutorialView();
          }
          break;
          case TutorialStepEnums.START_GHOST_INTRODUCTION:{
            startStepTwoInTutorial();
          }
          break;
          case TutorialStepEnums.START_COIN_INTRODUCTION:{
            startStepThreeInTutorial();
          }
          break;
          case TutorialStepEnums.ADDITIONAL_GAME_COLLECTIBLES:{
            startStepFourInTutorial();
          }
          break;
          case TutorialStepEnums.START_ACTUAL_GAME:{
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
    String lineOne = "Great! Now Amaze would let you know how to play this game.";
    bool isLineOneComplete = await _visionTts.speakText(lineOne);
    String lineTwo = "In a moment I will show you our game";
    bool isLineTwoComplete = await _visionTts.speakText(lineTwo);
    String lineThree = "At center of screen you will see our game hero and his name is ${ApplicationConstants.PlayerName}";
    bool isLineThreeComplete = await _visionTts.speakText(lineThree);
    String lineFour = "Now swipe left to see ${ApplicationConstants.PlayerName} walking";
    bool isLineFourComplete = await _visionTts.speakText(lineFour);
    bool isAllComplete = isLineOneComplete && isLineTwoComplete && isLineThreeComplete && isLineFourComplete;
    if(isAllComplete){
      _gameTutorialTriggers.addStepCounter(TutorialStepEnums.START_TUTORIAL_VIEW);
    }
    return Future.value(isAllComplete);
  }

  void startStepThreeInTutorial() async{
    String lineOne = "Now lets move on to Step Three.";
    bool isLineOneComplete = await _visionTts.speakText(lineOne);
    String lineTwo = "Amaze will now introduce you to game collectables.";
    bool isLineTwoComplete = await _visionTts.speakText(lineTwo);
    String lineThree = "In your screen you will now see a coin.";
    bool isLineThreeComplete = await _visionTts.speakText(lineThree);
    String lineFour = "You have to swipe on your screen and make ${ApplicationConstants.PlayerName} walk over coin to collect it";
    bool isLineFourComplete = await _visionTts.speakText(lineFour);
    /*String lineFive = "You have to move 3 places to your right and 4 places down to reach to your coin";
    bool isLineFiveComplete = await _visionTts.speakText(lineFive);*/
    bool isAllComplete = isLineOneComplete && isLineTwoComplete && isLineThreeComplete && isLineFourComplete;
    if(isAllComplete){
      _gameTutorialTriggers.addStepCounter(TutorialStepEnums.SPAWN_COIN);
    }
  }

  void startStepFourInTutorial() async{
    String lineOne = "In a similar way you will also see other collectibles in the game.";
    bool isLineOneComplete = await _visionTts.speakText(lineOne);
    String lineTwo = "Amaze would help you three times to reach to collectible from players position.";
    bool isLineTwoComplete = await _visionTts.speakText(lineTwo);
    String lineThree = "If you don't collect even after three times then Amaze would remove collectible and add a new one.";
    bool isLineThreeComplete = await _visionTts.speakText(lineThree);
    String lineFour = "Our new collectible will be at a new position";
    bool isLineFourComplete = await _visionTts.speakText(lineFour);
    //bool isComplete = isLineOneComplete && isLineTwoComplete;
    bool isComplete = isLineOneComplete && isLineTwoComplete && isLineThreeComplete && isLineFourComplete;
    if(isComplete){
      _gameTutorialTriggers.addStepCounter(TutorialStepEnums.START_ACTUAL_GAME);
    }
  }

  void startStepTwoInTutorial() async{
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
      _gameTutorialTriggers.addStepCounter(TutorialStepEnums.SPAWN_GHOST);
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
    //listenPlayerEvents();
    state = const GameScreenViewState.displayGameView();
  }

}