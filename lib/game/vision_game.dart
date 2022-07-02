import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:visiongame/game/components/ghost.dart';
import 'package:visiongame/game/components/vision_world.dart';
import 'package:visiongame/game/components/world_collidable.dart';
import 'components/player.dart';
import 'helpers/direction.dart';
import 'helpers/map_loader.dart';
import 'dart:async' as gameTimer;

/// This class encapulates the whole game.
class VisionGame extends FlameGame with HasCollisionDetection, DoubleTapDetector{
  final Player _player = Player();
  final Ghost _ghostPlayer = Ghost();
  final VisionWorld _world = VisionWorld();
  bool running = true;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_world);
    await add(_player);
    await add(_ghostPlayer);
    addWorldCollision();
    _player.position = _world.size / 1.5;
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));

    _ghostPlayer.position = _world.size / 1.6;
    gameTimer.Timer.periodic(Duration(seconds: 5), (timer) {
      //_ghostPlayer.position = camera.position;
      _ghostPlayer.switchDirection();

      _ghostPlayer.position = Vector2(camera.position.x + 30, camera.position.y + 60) ;
    });

  }

  onArrowKeyChanged(Direction direction){
    _player.direction = direction;
  }

  Player get getPlayer {
    return _player;
  }

  void addWorldCollision() async =>
      (await MapLoader.readRayWorldCollisionMap()).forEach((rect) {
        add(WorldCollidable()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });

  RectangleHitbox createWorldCollidable(Rect rect) {
    final collidable = RectangleHitbox();
    collidable.position = Vector2(rect.left, rect.top);
    collidable.width = rect.width;
    collidable.height = rect.height;
    return collidable;
  }

  @override
  void onDoubleTap() {
    if (running) {
      pauseEngine();
    } else {
      resumeEngine();
    }
    running = !running;
  }
}