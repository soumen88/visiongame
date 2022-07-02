import 'dart:async' as gameTimer;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:visiongame/base/logger_utils.dart';
import 'package:visiongame/game/components/vision_world.dart';

import '../../injector/injection.dart';

class Ghost extends SpriteComponent with HasGameRef, CollisionCallbacks {
  final _logger = locator<LoggerUtils>();
  final _TAG = "Ghost";
  double _gameWidth = 1500;
  ///By default in X Axis movement player would move to the left
  bool isLeft = true;
  ///By default in Y Axis movement player would move to the left
  bool isDown = true;
  bool? isXAxisMovement;
  bool? isYAxisMovement;
  Ghost()
      : super(
    size: Vector2.all(50.0),
  );

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('ghost.png');
    position = gameRef.size / 2;
    add(RectangleHitbox());
    isXAxisMovement = false;
    isYAxisMovement = true;
    gameTimer.Timer.periodic(
      const Duration(seconds: 20),
          (timer) {
            _logger.log(_TAG, "Changing direction $isLeft");
            isLeft = !isLeft;
            isDown = !isDown;
      },
    );


  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent  other) {
    super.onCollisionStart(intersectionPoints, other);

    if(other is ScreenHitbox){
      //_logger.log(_TAG, "Inside on collision with screen");
      //removeFromParent();
    }

  }

  @override
  void update(double dt) {
    super.update(dt);
    if(isXAxisMovement != null && isXAxisMovement!){
      if (isLeft) {
        this.x -= 0.25;
      }
      else{
        this.x += 0.25;
      }
    }

    if(isYAxisMovement != null && isYAxisMovement!){
      if (isDown) {
        this.y -= 0.25;
        //_logger.log(_TAG, "Doing minus across y axis");
      }
      else{
        this.y += 0.25;
        //_logger.log(_TAG, "Doing plus across y axis");
      }
    }

    /*if (_collision) {
      print('hit');
      remove();
    }*/
  }

  @override
  void onCollisionEnd(PositionComponent  other) {
    //_logger.log(_TAG, "On collision ended");
  }


  void switchDirection(){
    _logger.log(_TAG, "Inside switch direction");
    isXAxisMovement = !isXAxisMovement!;
    isYAxisMovement = !isYAxisMovement!;
  }

}