/** Copyright (c) 2021 Razeware LLC

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
    distribute, sublicense, create a derivative work, and/or sell copies of the
    Software in any work that is designed, intended, or marketed for pedagogical or
    instructional purposes related to programming, coding, application development,
    or information technology.  Permission for such use, copying, modification,
    merger, publication, distribution, sublicensing, creation of derivative works,
    or sale is expressly withheld.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE. **/

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:visiongame/base/constants.dart';
import 'package:visiongame/enums/player_life_status_enums.dart';
import 'package:visiongame/game/components/tutorial_ghost.dart';
import 'package:visiongame/game/components/world_collidable.dart';
import 'package:visiongame/injector/injection.dart';
import '../../base/logger_utils.dart';
import '../../texttospeech/vision_text_to_speech_converter.dart';
import '../helpers/direction.dart';
import 'package:flame/sprite.dart';

import '../models/player_motion_model.dart';
import '../triggers/game_triggers.dart';

class TutorialPlayer extends SpriteAnimationComponent with HasGameRef, CollisionCallbacks {
  final _logger = locator<LoggerUtils>();
  final _TAG = "TutorialPlayer";
  final _gameTriggers = locator<GameTriggers>();

  final double _playerSpeed = 100.0;
  final double _animationSpeed = 0.30;

  late final SpriteAnimation _runDownAnimation;
  late final SpriteAnimation _runLeftAnimation;
  late final SpriteAnimation _runUpAnimation;
  late final SpriteAnimation _runRightAnimation;
  late final SpriteAnimation _standingAnimation;

  Direction direction = Direction.none;
  Direction _collisionDirection = Direction.none;
  bool _hasCollided = false;
  bool isVoiceEnabled = true;
  bool isPlayerImmutable = false;
  final _visionTts = locator<VisionTextToSpeechConverter>();
  bool isPlayerMoving = false;
  TimerComponent? _oneTimeTimer;
  TutorialPlayer()
      : super(
    size: Vector2.all(45.0),
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    listenToVoiceInputEnabled();
    _loadAnimations().then((_) => {animation = _standingAnimation});
    add(RectangleHitbox());
    //add(ScreenHitbox());
    ///Start with initial lives as 3
    //_logger.log(_TAG, "Loading player sprite now");
  }

  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent  other) {
    super.onCollision(intersectionPoints, other);
    if (other is ScreenHitbox) {
      if (!_hasCollided) {
        _hasCollided = true;
        _collisionDirection = direction;
      }
    }
    if (other is WorldCollidable) {
      if (!_hasCollided) {
        _hasCollided = true;
        _collisionDirection = direction;
      }
    }
  }


  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent  other) async{
    super.onCollisionStart(intersectionPoints, other);

    if(other is TutorialGhost){
      //await _visionTts.speakStop();
      await _visionTts.speakText("Oh no! Don't let this happen. If the ghost touches ${ApplicationConstants.PlayerName} then he would lose a life");
    }

    ///Player would not die if it is immutable
    if (other is ScreenHitbox) {
      _gameTriggers.addPlayerEvent(PlayerLifeStatusEnums.PLAYER_CHANGE_DIRECTION, position);
      return;
    }


  }


  @override
  void onCollisionEnd(PositionComponent  other) {
    _hasCollided = false;
  }

  ///Once mike icon is set to turn off position the speaking for enemy position would stop
  void listenToVoiceInputEnabled(){
    _gameTriggers.isVoiceInputEnabled.listen((bool? isInputEnabled) {
      if(isInputEnabled != null){
        isVoiceEnabled = isInputEnabled;
      }
    });
  }


  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load('player_spritesheet.png'),
      ///First parameter is width and second is height
      srcSize: Vector2(29.0, 32.0),
    );

    _runDownAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 4);

    _runLeftAnimation =
        spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, to: 4);

    _runUpAnimation =
        spriteSheet.createAnimation(row: 2, stepTime: _animationSpeed, to: 4);

    _runRightAnimation =
        spriteSheet.createAnimation(row: 3, stepTime: _animationSpeed, to: 4);

    _standingAnimation =
        spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 1);
  }

  void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        if (canPlayerMoveUp() && isPlayerMoving == false) {
          animation = _runUpAnimation;
          moveUp(delta);
          //isPlayerMoving = true;
        }
        break;
      case Direction.down:
        if (canPlayerMoveDown() && isPlayerMoving == false) {
          animation = _runDownAnimation;
          moveDown(delta);
          //isPlayerMoving = true;
        }
        break;
      case Direction.left:
        if (canPlayerMoveLeft() && isPlayerMoving == false) {
          animation = _runLeftAnimation;
          moveLeft(delta);
          //isPlayerMoving = true;
        }
        break;
      case Direction.right:
        if (canPlayerMoveRight() && isPlayerMoving == false) {
          animation = _runRightAnimation;
          moveRight(delta);
          //isPlayerMoving = true;
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

  void updatePosition(){
    isPlayerMoving = false;
    add(
        _oneTimeTimer = TimerComponent(
          period: ApplicationConstants.playerDeltaValue,
          repeat: false,
          onTick: () async{
            isPlayerMoving = true;
            _oneTimeTimer?.removeFromParent();
          },
        )
    );

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

  void changeDirectionOnCollision(){
    switch(direction){
      case Direction.down:{
        direction = Direction.up;
      }
      break;
      case Direction.up :{
        direction = Direction.down;
      }
      break;
      case Direction.right :{
        direction = Direction.left;
      }
      break;
      case Direction.left :{
        direction = Direction.right;
      }
      break;
      case Direction.none :{
        direction = Direction.right;
      }
      break;
    }
  }
}
