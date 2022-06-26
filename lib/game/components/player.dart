import 'package:flame/components.dart';
import 'package:visiongame/injector/injection.dart';

import '../../base/logger_utils.dart';
import '../helpers/direction.dart';

class Player extends SpriteComponent with HasGameRef {
  final _logger = locator<LoggerUtils>();
  final _TAG = "Player";
  Direction direction = Direction.none;

  Player()
      : super(
    size: Vector2.all(50.0),
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('player.png');
    position = gameRef.size / 2;
  }


  @override
  void update(double dt) {
    super.update(dt);
    updatePosition(dt);
  }

  updatePosition(double dt) {
    switch (direction) {
      case Direction.up:
        position.y --;
        break;
      case Direction.down:
        position.y ++;
        break;
      case Direction.left:
        position.x --;
        break;
      case Direction.right:
        position.x ++;
        break;
      case Direction.none:
        break;
    }
  }
}
