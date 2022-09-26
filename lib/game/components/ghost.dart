import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/base/logger_utils.dart';
import 'package:visiongame/game/models/ghost_position_model.dart';
import '../../enums/difficulty_level_enum.dart';
import '../../injector/injection.dart';
import '../triggers/game_triggers.dart';

class Ghost extends SpriteComponent with HasGameRef, CollisionCallbacks {
  final _logger = locator<LoggerUtils>();
  final _TAG = "Ghost";

  ///By default in X Axis movement player would move to the left
  bool isLeft = true;
  ///By default in Y Axis movement player would move to the left
  bool isDown = false;
  bool isXAxisMovement = false;
  bool isYAxisMovement = true;
  bool isEnabled = false;
  final _random = Random();

  double _motionFactor = 0.25;
  final _gameTriggers = locator<GameTriggers>();

  final BehaviorSubject<GhostPositionModel?> ghostPositionNotifier = BehaviorSubject.seeded(null);

  Ghost() : super(size: Vector2.all(50.0));

  @override
  Future<void> onLoad() async {
    _logger.log(_TAG, "Loading ghost sprite now");
    sprite = await gameRef.loadSprite('ghost.png');
    //position = gameRef.size / 2;
    add(RectangleHitbox());
    ///Once this timer elapses then ghost position would be changed in game
    add(
        TimerComponent(
          period: 10,
          repeat: true,
          onTick: () async{
            await addGhostMotion();
          },
        )
    );
    //listenToDifficultyLevelChanges();
  }

  ///Depending upon difficulty level enemy is added in game
  Future<void> spawnGhost() async{
    await addGhostMotion();
    isEnabled = true;
  }


  Future<void> addGhostMotion() async{
    _logger.log(_TAG, "Changing direction of ghost");
    var randomNumber1 = next(1, 100);
    var randomNumber2 = next(7, 500);
    if(randomNumber1 % 2 == 0){
      isXAxisMovement = true;
      isYAxisMovement = false;
    }
    else{
      isXAxisMovement = false;
      isYAxisMovement = true;
    }
    if(randomNumber2 % 2 == 0){
      isLeft = true;
      isDown = true;
    }
    else{
      isLeft = false;
      isDown = false;
    }

    GhostPositionModel ghostPositionModel = GhostPositionModel(isLeft: isLeft, isDown: isDown, isXAxisMovement: isXAxisMovement, isYAxisMovement: isYAxisMovement);
    ghostPositionNotifier.add(ghostPositionModel);
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
    if(isEnabled){
      if(isXAxisMovement){
        if (isLeft) {
          this.x -= _motionFactor;
        }
        else{
          this.x += _motionFactor;
        }
      }

      if(isYAxisMovement){
        if (isDown) {
          this.y += _motionFactor;
          //_logger.log(_TAG, "Doing plus makes character go down");
        }
        else{
          this.y -= _motionFactor;
          //_logger.log(_TAG, "Doing minus makes character go up");
        }
      }
    }
  }

  @override
  void onCollisionEnd(PositionComponent  other) {
    //_logger.log(_TAG, "On collision ended");
  }


  void switchDirection(){
    _logger.log(_TAG, "Inside switch direction");
    isXAxisMovement = !isXAxisMovement;
    isYAxisMovement = !isYAxisMovement;
  }

  Future<void> speakMovement() async{
    String speakString = "";
    if(isLeft){
      if(isDown){
        speakString = "Enemy coming from left and walking down";
      }
      else{
        speakString = "Enemy coming from left and walking up";
      }
    }
    else{
      if(isDown){
        speakString = "Enemy coming from right and walking down";
      }
      else{
        speakString = "Enemy coming from right and walking up";
      }
    }
    _logger.log(_TAG, "Speak String $speakString");
    //await _visionTts.speakText(speakString);
  }

  /**
   * Generates a positive random integer uniformly distributed on the range
   * from [min], inclusive, to [max], exclusive.
   */
  int next(int min, int max) => min + _random.nextInt(max - min);

}