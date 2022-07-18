import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:visiongame/enums/game_component_enums.dart';
import 'package:visiongame/game/components/player.dart';
import 'package:visiongame/injector/injection.dart';

import '../../audioplayer/game_audio_player.dart';
import '../../base/logger_utils.dart';
import '../triggers/game_triggers.dart';

class Coins extends SpriteComponent with HasGameRef, CollisionCallbacks{

  final _TAG = "Coins";
  final _logger = locator<LoggerUtils>();
  final _gameTriggers = locator<GameTriggers>();
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
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Player){
      _logger.log(_TAG, "Now playing sound");
      _gameAudioPlayer.playGameSound(GameComponentEnums.COINS);
      _gameTriggers.addPlayerCoins(addCoins: true);
      removeFromParent();
    }
  }
}