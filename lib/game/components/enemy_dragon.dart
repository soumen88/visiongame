import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:rxdart/subjects.dart';
import 'package:visiongame/game/components/ghost.dart';
import 'package:visiongame/injector/injection.dart';
import '../../base/logger_utils.dart';
import '../helpers/direction.dart';
import 'package:flame/sprite.dart';

import '../models/ghost_position_model.dart';
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

  ///By default in X Axis movement player would move to the left
  bool isLeft = true;
  ///By default in Y Axis movement player would move to the left
  bool isDown = false;
  bool isXAxisMovement = false;
  bool isYAxisMovement = true;
  bool isRunning = true;

  final BehaviorSubject<GhostPositionModel?> dragonPositionNotifier = BehaviorSubject.seeded(null);

  EnemyDragon()
      : super(
    size: Vector2.all(100.0),
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _logger.log(_TAG, "Adding dragon");
    direction = DirectionEnumsExt.generateRandomUniqueDirection();
    await _loadAnimations().then((_) => {animation = _standingAnimation});
    add(ScreenHitbox());
    final Stream<int> _dragonDirectionStream = Stream.periodic(Duration(seconds: 8), (int count) {
      return count;
    }).takeWhile((element) => isRunning);

    _dragonDirectionStream.listen((int event) {

      direction = DirectionEnumsExt.generateRandomUniqueDirection();
      if(direction == Direction.up || direction == Direction.down){
        isYAxisMovement = true;
        isXAxisMovement = false;
        isLeft = false;
        if(direction == Direction.down){
          isDown = true;
        }
        else{
          isDown = false;
        }
      }
      else if(direction == Direction.left || direction == Direction.right) {
        isXAxisMovement = true;
        isYAxisMovement = false;
        if(direction == Direction.left){
          isLeft = true;
        }
        else{
          isLeft = false;
        }
      }
      //_logger.log(_TAG, "Is x axis $isXAxisMovement or is y axis $isYAxisMovement and direction $direction");
      GhostPositionModel dragonPositionModel = GhostPositionModel(isLeft: isLeft, isDown: isDown, isXAxisMovement: isXAxisMovement, isYAxisMovement: isYAxisMovement);
      dragonPositionNotifier.add(dragonPositionModel);
    });
  }

  @override
  void update(double delta) {
    super.update(delta);
    if(isRunning){
      movePlayer(delta);
    }
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
