import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/base/constants.dart';
import 'package:visiongame/base/logger_utils.dart';
import 'package:visiongame/game/models/ghost_position_model.dart';
import '../../injector/injection.dart';
import '../../texttospeech/vision_text_to_speech_converter.dart';

class Ghost extends SpriteComponent with HasGameRef, CollisionCallbacks {
  final _logger = locator<LoggerUtils>();
  final _TAG = "Ghost";

  ///By default in X Axis movement player would move to the left
  bool isLeft = true;
  ///By default in Y Axis movement player would move to the left
  bool isDown = false;
  bool isXAxisMovement = false;
  bool isYAxisMovement = true;

  ///Below variable is used for speaking about ghost position in the game
  final _visionTts = locator<VisionTextToSpeechConverter>();

  var _random = Random();

  bool isMicOn = true;

  double _motionFactor = 0.25;

  final BehaviorSubject<GhostPositionModel?> ghostPositionNotifier = BehaviorSubject.seeded(null);

  Ghost()
      : super(
    size: Vector2.all(50.0),
  );

  @override
  Future<void> onLoad() async {
    sprite = await gameRef.loadSprite('ghost.png');
    position = gameRef.size / 2;
    add(RectangleHitbox());
    final Stream<int> _ghostDirectionStream = Stream.periodic(Duration(seconds: 5), (int count) {
      return count;
    });

    await speakMovement();

    _ghostDirectionStream.listen((int event) async{
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
      /*_logger.log(_TAG, "Changing direction Xaxis $isLeft and Yaxis $isDown");
      _logger.log(_TAG, "Changing movement Xaxis $isXAxisMovement and Yaxis $isYAxisMovement");*/
      GhostPositionModel ghostPositionModel = GhostPositionModel(isLeft: isLeft, isDown: isDown, isXAxisMovement: isXAxisMovement, isYAxisMovement: isYAxisMovement);
      ghostPositionNotifier.add(ghostPositionModel);
    });

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