import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:visiongame/game/components/ghost.dart';
import 'package:visiongame/injector/injection.dart';
import '../../base/logger_utils.dart';
import '../helpers/direction.dart';
import 'package:flame/sprite.dart';

import '../triggers/game_triggers.dart';

class EnemyDragon extends SpriteAnimationComponent with HasGameRef, CollisionCallbacks {
  final _logger = locator<LoggerUtils>();
  final _TAG = "EnemyDragon";
  final _gameTriggers = locator<GameTriggers>();

  final double _playerSpeed = 100.0;
  final double _animationSpeed = 0.15;

  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;

  Direction direction = Direction.none;
  Direction _collisionDirection = Direction.none;
  bool _hasCollided = false;

  EnemyDragon()
      : super(
    size: Vector2.all(100.0),
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _logger.log(_TAG, "Adding dragon");
    direction = Direction.right;
    await _loadAnimations().then((_) => {animation = _standingAnimation});
    add(ScreenHitbox());
  }

  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent  other) {
    super.onCollision(intersectionPoints, other);
    //_logger.log(_TAG, "Inside on collision");
    if (other is ScreenHitbox) {
      if (!_hasCollided) {
        _hasCollided = true;
        _collisionDirection = direction;
      }
    }

  }


  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent  other) {
    super.onCollisionStart(intersectionPoints, other);

    if(other is Ghost){
      /*_gameTriggers.addPlayerEvent(PlayerLifeStatusEnums.PLAYER_DEAD, position);
      removeFromParent();*/
    }

  }


  @override
  void onCollisionEnd(PositionComponent  other) {
    _hasCollided = false;
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

  void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        if (canPlayerMoveUp()) {
          animation = _runUpAnimation;
          moveUp(delta);
        }
        break;
      case Direction.down:
        if (canPlayerMoveDown()) {
          animation = _runDownAnimation;
          moveDown(delta);
        }
        break;
      case Direction.left:
        if (canPlayerMoveLeft()) {
          animation = _runLeftAnimation;
          moveLeft(delta);
        }
        break;
      case Direction.right:
        if (canPlayerMoveRight()) {
          animation = _runRightAnimation;
          moveRight(delta);
        }
        break;
      case Direction.none:
        animation = _standingAnimation;
        break;
    }
  }

  bool canPlayerMoveUp() {
    if (_hasCollided && _collisionDirection == Direction.up) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveDown() {
    if (_hasCollided && _collisionDirection == Direction.down) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveLeft() {
    if (_hasCollided && _collisionDirection == Direction.left) {
      return false;
    }
    return true;
  }

  bool canPlayerMoveRight() {
    if (_hasCollided && _collisionDirection == Direction.right) {
      return false;
    }
    return true;
  }

  void moveUp(double delta) {
    position.add(Vector2(0, delta * -_playerSpeed));
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * _playerSpeed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed, 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * _playerSpeed, 0));
  }
}
