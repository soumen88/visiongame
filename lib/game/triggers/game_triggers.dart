import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../base/logger_utils.dart';
import '../../injector/injection.dart';

class GameTriggers{

  static final GameTriggers _instance = GameTriggers._init();

  static GameTriggers get instance => _instance;

  GameTriggers._init();

  final _logger = locator<LoggerUtils>();
  final _TAG = "GameTriggers";

  BehaviorSubject<int?> playerLifeStream = BehaviorSubject.seeded(null);

  BehaviorSubject<bool?> isPlayerDead = BehaviorSubject.seeded(null);

  void addPlayerDead(bool value){
    _logger.log(_TAG, "Received player dead $value");
    var playerLifeLeft = playerLifeStream.value!;
    playerLifeLeft = playerLifeLeft - 1;
    playerLifeStream.add(playerLifeLeft);
    isPlayerDead.add(value);
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
}