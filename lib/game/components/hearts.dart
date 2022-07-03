import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:visiongame/enums/player_life_status_enums.dart';
import 'package:visiongame/game/components/player.dart';
import 'package:visiongame/injector/injection.dart';

import '../../base/logger_utils.dart';
import '../triggers/game_triggers.dart';

class Hearts extends SpriteComponent with HasGameRef, CollisionCallbacks{

  final _TAG = "Hearts";
  final _logger = locator<LoggerUtils>();
  final _gameTriggers = locator<GameTriggers>();

  Hearts()
      : super(
    size: Vector2.all(50.0),
  );


  @override
  Future<void> onLoad() async{
    sprite = await gameRef.loadSprite('heart.png');
    position = gameRef.size / 2;
    add(RectangleHitbox());
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    if(other is Player){
      _gameTriggers.addPlayerEvent(PlayerLifeStatusEnums.PLAYER_ADD_LIFE, other.position);
      removeFromParent();
    }
  }
}