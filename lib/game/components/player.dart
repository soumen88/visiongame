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

import 'package:easy_localization/easy_localization.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:visiongame/base/constants.dart';
import 'package:visiongame/enums/player_life_status_enums.dart';
import 'package:visiongame/game/components/enemy_dragon.dart';
import 'package:visiongame/game/components/ghost.dart';
import 'package:visiongame/game/components/moth.dart';
import 'package:visiongame/game/components/ninja_girl.dart';
import 'package:visiongame/game/components/world_collidable.dart';
import 'package:visiongame/injector/injection.dart';
import '../../base/logger_utils.dart';
import '../../generated/locale_keys.g.dart';
import '../../texttospeech/vision_text_to_speech_converter.dart';
import '../helpers/direction.dart';
import 'package:flame/sprite.dart';

import '../models/player_motion_model.dart';
import '../triggers/game_triggers.dart';

class Player extends SpriteAnimationComponent with HasGameRef, CollisionCallbacks {
  final _logger = locator<LoggerUtils>();
  final _TAG = "Player";
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
  Player()
      : super(
    size: Vector2.all(45.0),
  );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    listenToVoiceInputEnabled();
    listenPlayerDead();
    listenPlayerImmutability();
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
    ///Player would not die if it is immutable
    if(isPlayerImmutable == false && ((other is EnemyDragon) || (other is NinjaGirl ) || (other is Ghost)) ){
      _gameTriggers.addPlayerEvent(PlayerLifeStatusEnums.PLAYER_DEAD, position);
      removeFromParent();
    }

    if (other is ScreenHitbox) {
      _logger.log(_TAG, 'Player has hit screen collidable ${position}');
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

  void listenPlayerDead(){
    _gameTriggers.playerLifeEventNotifier.listen((PlayerMotionModel? playerMotionModel) async{
      _logger.log(_TAG, "Player got dead $playerMotionModel");
      if(playerMotionModel != null && playerMotionModel.event == PlayerLifeStatusEnums.PLAYER_NEW_LIFE && playerMotionModel.playerLivesLeft >= 0){
        if(isVoiceEnabled){
          String playerDead = LocaleKeys.game_player_dead.tr();
          await _visionTts.speakStop();
          _visionTts.enableSpeaking();
          await _visionTts.speakText(playerDead);
        }
      }
    });
  }

  void listenPlayerImmutability(){
    _gameTriggers.isPlayerImmutable.listen((bool? playerImmutability) async{
      if(playerImmutability != null){
        isPlayerImmutable = playerImmutability;
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
    //_logger.log(_TAG, "Before position ${position}");
    add(
        _oneTimeTimer = TimerComponent(
          period: ApplicationConstants.playerDeltaValue,
          repeat: false,
          onTick: () async{
            isPlayerMoving = true;
            _oneTimeTimer?.removeFromParent();
            _logger.log(_TAG, "After position ${position}");
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
