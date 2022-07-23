import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';

import 'ninja_girl.dart';

class CollidableAnimationExample extends FlameGame with HasCollisionDetection {
  static const description = '''
    In this example you can see four animated birds which are flying straight
    along the same route until they hit either another bird or the wall, which
    makes them turn. The birds have PolygonHitboxes which are marked with the
    white lines.
  ''';

  @override
  Future<void> onLoad() async {
    add(ScreenHitbox());
    final componentSize = Vector2(150, 100);
    // Top left component
    add(
      AnimatedComponent(Vector2.all(200), Vector2.all(100), componentSize)
        ..flipVertically(),
    );
    // Bottom right component
    add(
      AnimatedComponent(
        Vector2(-100, -100),
        size.clone()..sub(Vector2.all(200)),
        componentSize / 2,
      ),
    );
    // Bottom left component
    add(
      AnimatedComponent(
        Vector2(100, -100),
        Vector2(100, size.y - 100),
        componentSize * 1.5,
        angle: pi / 4,
      ),
    );
    // Top right component
    add(
      AnimatedComponent(
        Vector2(-300, 300),
        Vector2(size.x - 100, 100),
        componentSize / 3,
        angle: pi / 4,
      )..flipVertically(),
    );
  }
}