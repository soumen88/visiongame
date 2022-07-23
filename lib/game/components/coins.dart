import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:visiongame/enums/game_component_enums.dart';
import 'package:visiongame/game/components/player.dart';
import 'package:visiongame/injector/injection.dart';

import '../../audioplayer/game_audio_player.dart';
import '../../base/logger_utils.dart';
import '../triggers/game_triggers.dart';
import '../triggers/game_tutorial_triggers.dart';

class Coins extends SpriteComponent with HasGameRef, CollisionCallbacks{

  final _TAG = "Coins";
  final _logger = locator<LoggerUtils>();
  final _gameTriggers = locator<GameTriggers>();
  final _gameTutorialTriggers = locator<GameTutorialTriggers>();
  final _gameAudioPlayer = locator<GameAudioPlayer>();
  Coins()
      : super(
    size: Vector2.all(50.0),
  );


  @override
  Future<void> onLoad() async{
    sprite = await gameRef.loadSprite('coin.png');
    position = gameRef.size / 2;
    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) async{
    if(other is Player){
      _logger.log(_TAG, "Now playing sound");
      if(_gameTutorialTriggers.isTutorialInProgress){
        int? currentStep = _gameTutorialTriggers.stepCounter.value;
        if(currentStep != null && currentStep == 3){
          _gameTutorialTriggers.addStepCounter(4);
        }
      }
      else{
        await _gameAudioPlayer.playGameSound(GameComponentEnums.COINS);
        _gameTriggers.addPlayerCoins(addCoins: true);
      }

      removeFromParent();
    }
  }

  void removeCoin(){
    removeFromParent();
  }
}