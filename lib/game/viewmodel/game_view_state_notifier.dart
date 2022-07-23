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
  final visionTts = locator<VisionTextToSpeechConverter>();

  ///Below variable is used for taking speech input from user
  final visionSpeechInput = locator<VisionSpeechInput>();

  ///Below variable is used for displaying bottom sheet on the game over screen
  BehaviorSubject<bool?> gameOverbottomSheetNotifier = BehaviorSubject<bool?>.seeded(null);

  ///If this flag is passed as true then game will be opened for tutorial view
  bool isTutorialView = true;

  GameViewStateNotifier() : super(const GameScreenViewState.loading()) {
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

  void listenPlayerEvents(){
    _gameTriggers.playerLifeEventNotifier.listen((PlayerMotionModel? playerMotionModel) {
      if(playerMotionModel != null && playerMotionModel.event == PlayerLifeStatusEnums.PLAYER_GAME_OVER){
        _logger.log(_TAG, "Player game over");
        _gameTriggers.toggleVoiceInput(stopSpeaking: true);
        state = GameScreenViewState.displayGameOver();
      }
    });
  }

  ///Whatever the user has spoken will be listened here
  void listenToSpeechInput(){
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


  void startGameOverScript() async{
    PermissionUtils permissionUtils = PermissionUtils();
    bool isPermissionGranted = await permissionUtils.askMicroPhonePermission();
    bool isSpeechInitialized = await visionSpeechInput.setUpVoiceInput();
    if(isPermissionGranted && isSpeechInitialized){
      String lineOne = "Alas, that was bad. We hope that you liked our game";
      await visionTts.speakText(lineOne);
      String lineTwo = "Do you want to continue playing our game?";
      await visionTts.speakText(lineTwo);
      String linethree = "Say yes to continue or double tap on the screen";
      await visionTts.speakText(linethree);
      reloadBottomSheet(true);
    }

  }

  ///When this function is loaded with value as true then bottom sheet is displayed on home screen
  ///for 5 seconds and then closed
  ///For this duration the speech input is also invoked for capturing what user is saying
  void reloadBottomSheet(bool value) async{
    if(value){
      gameOverbottomSheetNotifier.add(true);
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
      await visionTts.speakStop();
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
    bool isLineOneComplete = await visionTts.speakText(lineOne);
    String lineTwo = "In a moment I will show you our game";
    bool isLineTwoComplete = await visionTts.speakText(lineTwo);
    bool isAllComplete = isLineOneComplete && isLineTwoComplete;
    if(isAllComplete){
      _gameTutorialTriggers.addStepCounter(1);
    }
    String lineThree = "At center of screen you will see our game hero and his name is ${ApplicationConstants.PlayerName}";
    bool isLineThreeComplete = await visionTts.speakText(lineThree);
    String lineFour = "Now swipe left to see ${ApplicationConstants.PlayerName} walking";
    bool isLineFourComplete = await visionTts.speakText(lineFour);
    return Future.value(isAllComplete);
  }

  void startStepTwoInTutorial() async{
    String lineOne = "Now lets move on to Step Two.";
    bool isLineOneComplete = await visionTts.speakText(lineOne);
    String lineTwo = "Amaze will now introduce you to game collectables.";
    bool isLineTwoComplete = await visionTts.speakText(lineTwo);
    String lineThree = "In your screen you will now see a coin.";
    bool isLineThreeComplete = await visionTts.speakText(lineThree);
    bool isAllComplete = isLineOneComplete && isLineTwoComplete && isLineThreeComplete;
    if(isAllComplete){
      _gameTutorialTriggers.addStepCounter(3);
    }
    String lineFour = "Swipe on your screen and make ${ApplicationConstants.PlayerName} walk over coin to collect it";
    bool isLineFourComplete = await visionTts.speakText(lineFour);
  }

  void startStepThreeInTutorial() async{
    String lineOne = "Well as you know every story has a villain";
    bool isLineOneComplete = await visionTts.speakText(lineOne);
    String lineTwo = "In this game villain is a group of monsters";
    bool isLineTwoComplete = await visionTts.speakText(lineTwo);
    String lineThree = "In a moment you will see a monster";
    String lineThree = "${ApplicationConstants.PlayerName} has to avoid coming in contact with this monsters.";
  }

  void setTutorialView(bool value){
    isTutorialView = value;
  }

  void restartGame(){
    state = GameScreenViewState.displayGameView();
  }

}