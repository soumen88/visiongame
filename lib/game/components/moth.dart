import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:rxdart/rxdart.dart';

class Moth extends SpriteAnimationComponent with CollisionCallbacks, HasGameRef {
  final Vector2 velocity;

  BehaviorSubject<bool> mothPositionNotifier = BehaviorSubject.seeded(true);

  Moth(
      this.velocity,
      Vector2 position,
      Vector2 size, {
        double angle = (3*pi) / 4,
      }) : super(
    position: position,
    size: size,
    angle: angle,
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
      'bomb_ptero.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2.all(48),
      ),
    );
    final hitboxPaint = BasicPalette.white.paint()
      ..style = PaintingStyle.stroke
    ..color = Color.fromARGB(10, 102, 0, 204);
    add(
      PolygonHitbox.relative(
        [
          Vector2(0.0, -1.0),
          Vector2(-1.0, -0.1),
          Vector2(-0.2, 0.4),
          Vector2(0.2, 0.4),
          Vector2(1.0, -0.1),
        ],
        parentSize: size,
      )
        ..paint = hitboxPaint
        ..renderShape = false,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  final Paint hitboxPaint = BasicPalette.green.paint()
    ..style = PaintingStyle.stroke;
  final Paint dotPaint = BasicPalette.red.paint()..style = PaintingStyle.stroke;

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    super.onCollisionStart(intersectionPoints, other);
    /*bool currentValue = mothPositionNotifier.value;
    currentValue = !currentValue;
    mothPositionNotifier.add(currentValue);*/
    velocity.negate();
    flipVertically();
  }
}