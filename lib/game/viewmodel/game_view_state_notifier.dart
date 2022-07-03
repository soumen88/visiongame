import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/game/models/game_screen_view_state.dart';
import 'package:visiongame/injector/injection.dart';

import '../../base/constants.dart';
import '../../base/logger_utils.dart';
import '../../enums/player_life_status_enums.dart';
import '../../enums/speech_input_enums.dart';
import '../../texttospeech/vision_text_to_speech_converter.dart';
import '../../voiceinput/vision_speech_input.dart';
import '../models/player_motion_model.dart';
import '../triggers/game_triggers.dart';

class GameViewStateNotifier extends StateNotifier<GameScreenViewState>{

  final _logger = locator<LoggerUtils>();
  final _TAG = "GameViewStateNotifier";
  final _gameTriggers = locator<GameTriggers>();
  ///Below variable is used for text to speech
  final visionTts = locator<VisionTextToSpeechConverter>();

  ///Below variable is used for taking speech input from user
  final visionSpeechInput = locator<VisionSpeechInput>();

  ///Below variable is used for displaying bottom sheet on the game over screen
  BehaviorSubject<bool?> gameOverbottomSheetNotifier = BehaviorSubject<bool?>.seeded(null);

  GameViewStateNotifier() : super(const GameScreenViewState.displayGameOver()) {
    listenPlayerEvents();
  }

  void listenPlayerEvents(){
    _gameTriggers.playerLifeEventNotifier.listen((PlayerMotionModel? playerMotionModel) {
      if(playerMotionModel != null && playerMotionModel.event == PlayerLifeStatusEnums.PLAYER_GAME_OVER){
        _logger.log(_TAG, "Player game over");
        state = GameScreenViewState.displayGameOver();
      }
    });
  }

  void startGameOverScript() async{
    String lineOne = "Alas, that was bad. We hope that you liked our game";
    await visionTts.speakText(lineOne);
    String lineTwo = "Do you want to continue playing our game";
    await visionTts.speakText(lineTwo);
    reloadBottomSheet(true);
  }

  ///When this function is loaded with value as true then bottom sheet is displayed on home screen
  ///for 5 seconds and then closed
  ///For this duration the speech input is also invoked for capturing what user is saying
  void reloadBottomSheet(bool value) async{
    gameOverbottomSheetNotifier.add(true);
    await visionSpeechInput.startListening(SpeechInputEnums.START_GAME);
    Future.delayed(Duration(seconds: ApplicationConstants.kTimerLimit),() async{
      gameOverbottomSheetNotifier.add(false);
      await visionSpeechInput.stopListening();
    });
  }


}