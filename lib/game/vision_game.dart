import 'dart:ui';

import 'package:flame/game.dart';
import 'package:visiongame/game/components/vision_world.dart';

import 'components/player.dart';
import 'helpers/direction.dart';

/// This class encapulates the whole game.
class VisionGame extends FlameGame{
  final Player _player = Player();
  final VisionWorld _world = VisionWorld();
  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_world);
    await add(_player);

    _player.position = _world.size / 1.5;
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));

  }

  onArrowKeyChanged(Direction direction){
    _player.direction = direction;
  }
}