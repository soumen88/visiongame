import 'package:flame/game.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/game/models/player_motion_model.dart';

import '../../base/logger_utils.dart';
import '../../injector/injection.dart';

class GameTriggers{

  static final GameTriggers _instance = GameTriggers._init();

  static GameTriggers get instance => _instance;

  GameTriggers._init();

  final _logger = locator<LoggerUtils>();
  final _TAG = "GameTriggers";

  ///Below variable keeps track of players life in the game
  BehaviorSubject<int?> playerLifeStream = BehaviorSubject.seeded(null);

  ///Below variable keeps track of number of coins that player would collect in the game
  BehaviorSubject<int?> playerCoinsStream = BehaviorSubject.seeded(null);

  BehaviorSubject<PlayerMotionModel?> isPlayerDead = BehaviorSubject.seeded(null);

  BehaviorSubject<bool?> addCoinInGame = BehaviorSubject.seeded(null);

  void addPlayerDead(Vector2 playerPosition){

    var playerLifeLeft = playerLifeStream.value!;
    playerLifeLeft = playerLifeLeft - 1;
    playerLifeStream.add(playerLifeLeft);
    PlayerMotionModel playerMotionModel = PlayerMotionModel(event: "Death", position: playerPosition);
    isPlayerDead.add(playerMotionModel);
  }

  void addPlayerLife({bool isInitial = false, required bool addlife} ){
    if(isInitial){
      _logger.log(_TAG, "Adding life to player");
      playerLifeStream.add(3);
    }
    else if(addlife){
      int currentLifes = playerLifeStream.value!;
      currentLifes++;
      playerLifeStream.add(currentLifes);
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

  void addCoin(bool value){

  }
}