import 'package:flame/game.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/base/constants.dart';
import 'package:visiongame/enums/player_life_status_enums.dart';
import 'package:visiongame/game/models/player_motion_model.dart';

import '../../base/logger_utils.dart';
import '../../injector/injection.dart';

class GameTriggers{

  static final GameTriggers _instance = GameTriggers._init();

  static GameTriggers get instance => _instance;

  GameTriggers._init();

  final _logger = locator<LoggerUtils>();
  final _TAG = "GameTriggers";

  ///Below variable keeps track of number of coins that player would collect in the game
  BehaviorSubject<int?> playerCoinsStream = BehaviorSubject.seeded(null);

  ///Below variable keeps track of players life in the game
  BehaviorSubject<PlayerMotionModel?> playerLifeEventNotifier = BehaviorSubject.seeded(null);

  ///Below variable indicates if game is paused or running
  BehaviorSubject<bool?> isGamePausedNotifer = BehaviorSubject.seeded(null);

  ///Below variable decides if game can be controlled with voice input
  BehaviorSubject<bool?> isVoiceInputEnabled = BehaviorSubject<bool?>.seeded(null);


  void addPlayerEvent(PlayerLifeStatusEnums event, Vector2 playerPosition, {bool isInitial = false}){
    if(isInitial){
      PlayerMotionModel playerMotionModel = PlayerMotionModel(event: event, position: playerPosition, playerLivesLeft: ApplicationConstants.kInitialPlayerLifes);
      playerLifeEventNotifier.add(playerMotionModel);
    }
    if(event == PlayerLifeStatusEnums.PLAYER_DEAD){
      var playerMotionModel = playerLifeEventNotifier.value!;
      if(playerMotionModel.playerLivesLeft > 0){
        int remainingLivesLeft = playerMotionModel.playerLivesLeft - 1;
        PlayerMotionModel newPlayerModel = PlayerMotionModel(event: PlayerLifeStatusEnums.PLAYER_NEW_LIFE, position: playerPosition, playerLivesLeft: remainingLivesLeft);
        playerLifeEventNotifier.add(newPlayerModel);
      }
      else{
        PlayerMotionModel newPlayerModel = PlayerMotionModel(event: PlayerLifeStatusEnums.PLAYER_GAME_OVER, position: playerPosition, playerLivesLeft: 0);
        playerLifeEventNotifier.add(newPlayerModel);
      }
    }

    if(event == PlayerLifeStatusEnums.PLAYER_ADD_LIFE){
      var playerMotionModel = playerLifeEventNotifier.value!;
      int remainingLivesLeft = playerMotionModel.playerLivesLeft + 1;
      PlayerMotionModel newPlayerModel = PlayerMotionModel(event: PlayerLifeStatusEnums.PLAYER_NEW_LIFE, position: playerPosition, playerLivesLeft: remainingLivesLeft);
      playerLifeEventNotifier.add(newPlayerModel);
    }
  }

  void addPlayerCoins({bool isInitial = false, required bool addCoins} ){
    if(isInitial){
      _logger.log(_TAG, "Adding life to player");
      playerCoinsStream.add(0);
    }
    else if(addCoins){
      int currentCoins = playerCoinsStream.value!;
      currentCoins++;
      playerCoinsStream.add(currentCoins);
    }
  }

  void addGamePauseOrResume({required bool isGamePaused}){
    if(isGamePaused){
      isGamePausedNotifer.add(true);
    }
    else{
      isGamePausedNotifer.add(false);
    }
  }

  void toggleVoiceInput({bool isInitial = false, bool stopSpeaking = false}){
    ///Assuming initially voice input will be enabled for the game
    if(isInitial){
      isVoiceInputEnabled.add(true);
    }
    else if(stopSpeaking){
      isVoiceInputEnabled.add(false);
    }
    else{
      bool currentValue = isVoiceInputEnabled.value!;
      currentValue = !currentValue;
      isVoiceInputEnabled.add(currentValue);
    }

  }

}