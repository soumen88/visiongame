import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame/sprite.dart';
import 'package:visiongame/injector/injection.dart';

import '../../base/logger_utils.dart';
import '../helpers/direction.dart';


class AnimatedComponent extends SpriteAnimationComponent with CollisionCallbacks, HasGameRef {
  final Vector2 velocity;
  final double _playerSpeed = 100.0;
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;
  Direction direction = Direction.none;
  final _logger = locator<LoggerUtils>();
  final _TAG = "AnimatedComponent";

  AnimatedComponent(
      this.velocity,
      Vector2 position,
      Vector2 size, {
        double angle = -pi / 2,
      }) : super(
    position: position,
    size: size,
    angle: angle,
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {

    await _loadAnimations().then((_) => {animation = _runDownAnimation});
    final hitboxPaint = BasicPalette.red.paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0;
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
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other,) {
    super.onCollisionStart(intersectionPoints, other);
    velocity.negate();
    flipVertically();
  }


  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if(other is ScreenHitbox){
      //_logger.log(_TAG, "Is colliding with screen");
      /*if(direction != Direction.none){
        if(direction == Direction.up){
          animation = _runUpAnimation;
        }
        else if(direction == Direction.down){
          animation = _runDownAnimation;
        }
        else if(direction == Direction.left){
          animation = _runLeftAnimation;
        }
        else if(direction == Direction.right){
          animation = _runRightAnimation;
        }
      }*/
    }
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('dragon_sprite_sheet.png'),
      ///First parameter is width and second is height
      srcSize: Vector2(192, 192),
    );

    _runDownAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 3);

    _runLeftAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 3);

    _runRightAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 3);

    _runUpAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 3);

    _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

}