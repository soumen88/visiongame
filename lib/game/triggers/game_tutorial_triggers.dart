import 'package:flame/game.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/base/constants.dart';
import 'package:visiongame/enums/difficulty_level_enum.dart';
import 'package:visiongame/enums/player_life_status_enums.dart';
import 'package:visiongame/enums/tutorial_step_enums.dart';
import 'package:visiongame/game/models/player_motion_model.dart';

import '../../base/logger_utils.dart';
import '../../injector/injection.dart';

class GameTutorialTriggers{

  static final GameTutorialTriggers _instance = GameTutorialTriggers._init();

  static GameTutorialTriggers get instance => _instance;

  GameTutorialTriggers._init();

  final _logger = locator<LoggerUtils>();
  final _TAG = "GameTutorialTriggers";

  ///Below variable indicates if game is paused or running
  BehaviorSubject<bool?> isGamePausedNotifer = BehaviorSubject.seeded(null);

  ///Below variable decides if game can be controlled with voice input
  BehaviorSubject<bool?> isVoiceInputEnabled = BehaviorSubject<bool?>.seeded(null);

  ///Below variable decides what is players walk speed in game
  BehaviorSubject<DifficultyLevelEnums?> gameDifficultyLevelStream = BehaviorSubject.seeded(null);

  ///Below variable counts at which step currently tutorial is been played at
  BehaviorSubject<TutorialStepEnums?> stepCounter = BehaviorSubject.seeded(null);

  bool isTutorialInProgress = false;



  void addGamePauseOrResume({required bool isGamePaused}){
    if(isGamePaused){
      isGamePausedNotifer.add(true);
    }
    else{
      isGamePausedNotifer.add(false);
    }
  }


  void setTutorialInProgress(bool value){
    isTutorialInProgress = value;
  }

  ///1 - Tutorial begins
  ///2 - Introduction to ghost
  ///3 - Adding coin to game view
  ///4 - Collect coin
  ///5 - Removing coin on three calls from game view
  ///6 - Start Game
  void addStepCounter(TutorialStepEnums stepValue){
    stepCounter.add(stepValue);
    _logger.log(_TAG, "Current step counter ${stepCounter.value}");
  }

  void resetTutorial(){
    isGamePausedNotifer = BehaviorSubject.seeded(null);

    isVoiceInputEnabled = BehaviorSubject<bool?>.seeded(null);

    ///Below variable decides what is players walk speed in game
    gameDifficultyLevelStream = BehaviorSubject.seeded(null);

    ///Below variable counts at which step currently tutorial is been played at
    stepCounter = BehaviorSubject.seeded(null);

    isTutorialInProgress = false;
  }

}