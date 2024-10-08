import 'dart:math';
import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flame/camera.dart';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/experimental.dart';
import 'package:flame/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:visiongame/base/constants.dart';
import 'package:visiongame/enums/collectible_quadrant_enums.dart';
import 'package:visiongame/enums/player_life_status_enums.dart';
import 'package:visiongame/game/components/coins.dart';
import 'package:visiongame/game/components/enemy_dragon.dart';
import 'package:visiongame/game/components/ghost.dart';
import 'package:visiongame/game/components/hearts.dart';
import 'package:visiongame/game/components/ninja_girl.dart';
import 'package:visiongame/game/components/vision_world.dart';
import 'package:visiongame/game/components/world_collidable.dart';
import 'package:visiongame/game/models/ghost_position_model.dart';
import 'package:visiongame/game/models/player_motion_model.dart';
import 'package:visiongame/game/triggers/game_triggers.dart';
import 'package:visiongame/injector/injection.dart';
import '../base/logger_utils.dart';
import '../enums/difficulty_level_enum.dart';
import '../generated/locale_keys.g.dart';
import '../texttospeech/vision_text_to_speech_converter.dart';
import 'components/player.dart';
import 'helpers/direction.dart';
import 'helpers/map_loader.dart';

/// This class encapulates the whole game.
class VisionGame extends FlameGame with HasCollisionDetection, DoubleTapDetector{
  final _logger = locator<LoggerUtils>();
  final _TAG = "VisionGame";
  final Player _player = Player();

  final EnemyDragon _dragon = EnemyDragon();
  final Ghost _ghostPlayer = Ghost();
  final NinjaGirl _ninjaGirl = NinjaGirl();

  final VisionWorld _world = VisionWorld();
  ///Game Collectables
  final Hearts _hearts = Hearts();
  final Coins _coins = Coins();

  int screenHeight;
  int screenWidth;
  bool running = true;
  final _gameTriggers = locator<GameTriggers>();
  final _random = Random();
  bool isVoiceEnabled = true;
  ///Below variable is used for speaking about ghost position in the game
  final _visionTts = locator<VisionTextToSpeechConverter>();
  late String enemyName;
  ///If collectible is not picked within this counter time then it would be removed
  ///and then a new collectible will be added
  int collectibleCounter = 3;

  ///If below variable is true then player cannot move
  bool isPlayerMovementLocked = false;

  VisionGame({required this.screenWidth, required this.screenHeight}){
    listenPlayerDead();
    listenToGhostMovement();
    listenToVoiceInputEnabled();
    listenToDifficultyLevelChanges();
  }

  void listenPlayerDead(){
    _gameTriggers.playerLifeEventNotifier.listen((PlayerMotionModel? playerMotionModel) {
      if(playerMotionModel != null && playerMotionModel.event == PlayerLifeStatusEnums.PLAYER_NEW_LIFE){
        Future.delayed(Duration(seconds: 4), () async{
          changePlayerWalkDirection();
          await world.add(_player);
          _gameTriggers.setImmutability();
        });
      }
      else if(playerMotionModel != null && playerMotionModel.event == PlayerLifeStatusEnums.PLAYER_CHANGE_DIRECTION){
        changePlayerWalkDirection(shouldSpeakDirection: true);
      }
    });
  }

  ///Once player is touching edge of the phone
  void changePlayerWalkDirection({bool shouldSpeakDirection = false}) async{
    ///Reversing the direction of player when he spawns again into game
    switch(_player.direction){
      case Direction.down:{
        _player.direction = Direction.up;
        _player.position.y = _player.position.y - (4 * ApplicationConstants.deltaValue);
      }
      break;
      case Direction.up :{
        _player.direction = Direction.down;
        _player.position.y = _player.position.y + (4 * ApplicationConstants.deltaValue);
      }
      break;
      case Direction.right :{
        _player.direction = Direction.left;
        _player.position.x = _player.position.x - (4 * ApplicationConstants.deltaValue);
      }
      break;
      case Direction.left :{
        _player.direction = Direction.right;
        _player.position.x = _player.position.x + (4 * ApplicationConstants.deltaValue);
      }
      break;
      case Direction.none :{
        _player.direction = Direction.right;
      }
      break;
    }

  }

  ///This function would work with all types of villains like ghost, dragon and moth
  void listenToGhostMovement(){
    _ghostPlayer.ghostPositionNotifier.listen((GhostPositionModel? ghostPositionModel) async{
      if(ghostPositionModel != null && running){
        int randomX = next(1, 5);
        int randomY = next(1, 12);
        int randomNumberOne = next(-10, 10);
        int randomNumberTwo = next(-10, 10);
        //_ghostPlayer.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
        if(randomNumberOne > 0){
          if(randomNumberTwo > 0){
            ///This will make ghost appear in 4th quadrant
            _ghostPlayer.position = Vector2(
                _player.position.x + (randomX * ApplicationConstants.deltaValue),
                _player.position.y + (randomY * ApplicationConstants.deltaValue)
            );
          }
          else{
            ///This will make ghost appear in 3rd quadrant
            _ghostPlayer.position = Vector2(
                _player.position.x + (randomX * -ApplicationConstants.deltaValue),
                _player.position.y + (randomY * ApplicationConstants.deltaValue)
            );
          }
        }
        else {
          if(randomNumberTwo > 0){
            ///This will make ghost appear in 2nd quadrant
            _ghostPlayer.position = Vector2(
                _player.position.x + (randomX * -ApplicationConstants.deltaValue),
                _player.position.y + (randomY * -ApplicationConstants.deltaValue)
            );
          }
          else{
            ///This will make ghost appear in 1st quadrant
            _ghostPlayer.position = Vector2(
                _player.position.x + (randomX * ApplicationConstants.deltaValue),
                _player.position.y + (randomY * -ApplicationConstants.deltaValue)
            );
          }
        }

        if(isVoiceEnabled){
          await speakMovement(ghostPositionModel, _ghostPlayer.position);
        }
      }
    });

    _dragon.dragonPositionNotifier.listen((GhostPositionModel? dragonPositionModel) async{
      if(dragonPositionModel != null && running){
        int randomX = next(1, 6);
        int randomY = next(1, 12);
        int randomNumberOne = next(-10, 10);
        int randomNumberTwo = next(-10, 10);
        //_dragon.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
        if(randomNumberOne > 0){
          if(randomNumberTwo > 0){
            ///This will make ghost appear in 4th quadrant
            _dragon.position = Vector2(
                _player.position.x + (randomX * ApplicationConstants.deltaValue),
                _player.position.y + (randomY * ApplicationConstants.deltaValue)
            );
          }
          else{
            ///This will make ghost appear in 3rd quadrant
            _dragon.position = Vector2(
                _player.position.x + (randomX * -ApplicationConstants.deltaValue),
                _player.position.y + (randomY * ApplicationConstants.deltaValue)
            );
          }
        }
        else {
          if(randomNumberTwo > 0){
            ///This will make ghost appear in 2nd quadrant
            _dragon.position = Vector2(
                _player.position.x + (randomX * -ApplicationConstants.deltaValue),
                _player.position.y + (randomY * -ApplicationConstants.deltaValue)
            );
          }
          else{
            ///This will make ghost appear in 1st quadrant
            _dragon.position = Vector2(
                _player.position.x + (randomX * ApplicationConstants.deltaValue),
                _player.position.y + (randomY * -ApplicationConstants.deltaValue)
            );
          }
        }
        if(isVoiceEnabled){
          await speakMovement(dragonPositionModel, _dragon.position);
        }
      }
    });

    _ninjaGirl.ninjaPositionNotifier.listen((GhostPositionModel? ninjaPositionModel) async{
      if(ninjaPositionModel != null && running){
        int randomX = next(1, 6);
        int randomY = next(1, 12);
        int randomNumberOne = next(-10, 10);
        int randomNumberTwo = next(-10, 10);
        //_dragon.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
        if(randomNumberOne > 0){
          if(randomNumberTwo > 0){
            ///This will make ghost appear in 4th quadrant
            _ninjaGirl.position = Vector2(
                _player.position.x + (randomX * ApplicationConstants.deltaValue),
                _player.position.y + (randomY * ApplicationConstants.deltaValue)
            );
          }
          else{
            ///This will make ghost appear in 3rd quadrant
            _ninjaGirl.position = Vector2(
                _player.position.x + (randomX * -ApplicationConstants.deltaValue),
                _player.position.y + (randomY * ApplicationConstants.deltaValue)
            );
          }
        }
        else {
          if(randomNumberTwo > 0){
            ///This will make ghost appear in 2nd quadrant
            _ninjaGirl.position = Vector2(
                _player.position.x + (randomX * -ApplicationConstants.deltaValue),
                _player.position.y + (randomY * -ApplicationConstants.deltaValue)
            );
          }
          else{
            ///This will make ghost appear in 1st quadrant
            _ninjaGirl.position = Vector2(
                _player.position.x + (randomX * ApplicationConstants.deltaValue),
                _player.position.y + (randomY * -ApplicationConstants.deltaValue)
            );
          }
        }
        if(isVoiceEnabled){
          await speakMovement(ninjaPositionModel, _ninjaGirl.position);
        }
      }
    });
  }

  ///Once mike icon is set to turn off position the speaking for enemy position would stop
  void listenToVoiceInputEnabled(){
    _gameTriggers.isVoiceInputEnabled.listen((bool? isInputEnabled) async{
      if(isInputEnabled != null){
        isVoiceEnabled = isInputEnabled;
        if(isVoiceEnabled){
          _logger.log(_TAG, "Setting up tts");
          _visionTts.enableSpeaking();
        }
        else{
          await _visionTts.speakStop();
        }
      }
    });
  }

  ///Depending upon difficulty level enemy is added in game
  Future<void> listenToDifficultyLevelChanges() async{
    _gameTriggers.gameDifficultyLevelStream.listen((DifficultyLevelEnums? currentDifficultyLevel) async{
      if(currentDifficultyLevel != null){
        ///Once difficulty level changes give player new life and coins
        _gameTriggers.addPlayerEvent(PlayerLifeStatusEnums.PLAYER_INIT, _player.position, isInitial: true);
        if(currentDifficultyLevel == DifficultyLevelEnums.EASY){
          _logger.log(_TAG, "Received event for easy level with ${_ghostPlayer.isMounted}");
          enemyName = "Ghost";
          await _visionTts.speakStop();
          _visionTts.enableSpeaking();
          String beginText = LocaleKeys.game_begin.tr(namedArgs: {
            'enemyName' : enemyName,
            'kLevelEasyCompletionCoins': ApplicationConstants.kLevelEasyCompletionCoins.toString()
          });
          await _visionTts.speakText(beginText);
          _dragon.isEnabled = false;
          _dragon.removeFromParent();
          _ninjaGirl.removeFromParent();
          //_ghostPlayer.position = _world.size / 1.6;
          int randomX = next(50, 400);
          int randomY = next(50, 400);
          _ghostPlayer.position = Vector2(camera.viewport.position.x + randomX, camera.viewport.position.y + randomY);
          _ghostPlayer.spawnGhost();
        }
        else if(currentDifficultyLevel == DifficultyLevelEnums.MEDIUM){
          _logger.log(_TAG, "Received event for medium level");
          _ghostPlayer.isEnabled = false;
          _ghostPlayer.removeFromParent();
          enemyName = "Dragon";
          //await _visionTts.speakStop();
          String levelClearEasy = LocaleKeys.game_level_clear_easy.tr(namedArgs: {
            'enemyName' : enemyName
          });
          String toDefeatEnemy = LocaleKeys.game_to_defeat_enemy.tr(namedArgs: {
            'enemyName' : enemyName,
            'kLevelMediumCompletionCoins' : ApplicationConstants.kLevelMediumCompletionCoins.toString()
          });
          await _visionTts.speakText(levelClearEasy);
          await _visionTts.speakText(toDefeatEnemy);
          int randomX = next(50, 400);
          int randomY = next(50, 400);
          await world.add(_dragon);
          _dragon.position = Vector2(camera.viewport.position.x + randomX, camera.viewport.position.y + randomY);
          _dragon.spawnDragon();
        }
        else if(currentDifficultyLevel == DifficultyLevelEnums.HARD){
          _logger.log(_TAG, "Received event for hard level");
          _dragon.isEnabled = false;
          _dragon.removeFromParent();
          enemyName = "Wing Devil";
          int randomX = next(50, 400);
          int randomY = next(50, 400);
          await _visionTts.speakStop();
          _visionTts.enableSpeaking();
          String levelHard = LocaleKeys.game_level_clear_medium.tr(namedArgs: {
            'enemyName' : enemyName,
          });
          String toDefeatEnemy = LocaleKeys.game_to_defeat_enemy.tr(namedArgs: {
            'enemyName' : enemyName,
            'kLevelCompletionCoins' : ApplicationConstants.kLevelHardCompletionCoins.toString()
          });
          await _visionTts.speakText(levelHard);
          await _visionTts.speakText(toDefeatEnemy);
          await world.add(_ninjaGirl);
          _ninjaGirl.position = Vector2(camera.viewport.position.x + randomX, camera.viewport.position.y + randomY);
          _ninjaGirl.spawnNinjaGirl();
        }
      }
    });
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _logger.log(_TAG, "inside on load");
    await world.add(_world);
    await world.add(_player);
    _logger.log(_TAG, "Our World size ${_world.size} and }");
    _player.position = _world.size / 1.5;
    await addWorldCollision();
    await world.add(_ghostPlayer);
    _gameTriggers.setDifficultyLevel(DifficultyLevelEnums.EASY);
    //_visionTts.setUpTtsListeners();
    //camera.followComponent(_player, worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
    camera
      ..viewfinder.visibleGameSize = Vector2(screenWidth.toDouble(), screenHeight.toDouble())
      ..follow(_player)
      //..setBounds(Rectangle.fromLTRB(182.9, 380.2, _world.size.x, _world.size.y));
      ..setBounds(Rectangle.fromLTRB(182.9, 380.2, 2200, 2000));


  }

  onArrowKeyChanged(Direction direction){
    if(isPlayerMovementLocked == false){
      _player.direction = direction;
      _player.updatePosition();
      _player.isPlayerImmutable = false;
    }

  }

  Player get getPlayer {
    return _player;
  }

  Future<bool> addCoinInGame() async{
    bool isCoinRemoved = false;
    if(_coins.isMounted){
      collectibleCounter--;
      _logger.log(_TAG, "Collectible counter $collectibleCounter");
      if(collectibleCounter == 0){
        _logger.log(_TAG, "remove coin on purpose");
        isCoinRemoved = true;
        collectibleCounter = 3;
        _coins.removeFromParent();
        String removeCollectible = LocaleKeys.game_collectible_removed.tr(namedArgs:{
          'appName' : ApplicationConstants.APP_NAME
        });
        await _visionTts.speakText(removeCollectible);
      }
      else{
        bool isLeft = _player.position.x > _coins.x ;
        bool isUp = _player.position.y > _coins.y ;
        _logger.log(_TAG, "Is left $isLeft, or up is $isUp");
        if(isLeft && isUp){
          _coins.currentQuadrant = CollectibleQuadrantEnums.SECOND;
        }
        else if(isLeft == false && isUp){
          _coins.currentQuadrant = CollectibleQuadrantEnums.FIRST;
        }
        else if(isLeft && isUp == false){
          _coins.currentQuadrant = CollectibleQuadrantEnums.THIRD;
        }
        else if(isLeft == false && isUp == false){
          _coins.currentQuadrant = CollectibleQuadrantEnums.FOURTH;
        }
      }
    }
    if(running &&  !_coins.isMounted){
      int randomX = next(1, 5);
      //int randomX = 2;
      int randomY = next(1, 8);
      //int randomY = 3;
      int randomNumberOne = next(-10, 10);
      int randomNumberTwo = next(-10, 10);
      isCoinRemoved = false;
      await world.add(_coins);

      if(randomNumberOne > 0){
        if(randomNumberTwo > 0){
          ///This will make coin appear in 4th quadrant
          _coins.position =
              Vector2(
                  _player.position.x + (randomX * ApplicationConstants.deltaValue),
                  _player.position.y + (randomY * ApplicationConstants.deltaValue)
              );
          _coins.currentQuadrant = CollectibleQuadrantEnums.FOURTH;
        }
        else{
          ///This will make coin appear in 3rd quadrant
          _coins.position =
              Vector2(
                  _player.position.x + (randomX * -ApplicationConstants.deltaValue),
                  _player.position.y + (randomY * ApplicationConstants.deltaValue)
              );
          _coins.currentQuadrant = CollectibleQuadrantEnums.THIRD;
        }
      }
      else {
        if(randomNumberTwo > 0){
          ///This will make coin appear in 2nd quadrant
          _coins.position = Vector2(
              _player.position.x + (randomX * -ApplicationConstants.deltaValue),
              _player.position.y + (randomY * -ApplicationConstants.deltaValue)
          );
          _coins.currentQuadrant = CollectibleQuadrantEnums.SECOND;
        }
        else{
          ///This will make coin appear in 1st quadrant
          _coins.position =
              Vector2(
                  _player.position.x + (randomX * ApplicationConstants.deltaValue),
                  _player.position.y + (randomY * -ApplicationConstants.deltaValue)
              );
          _coins.currentQuadrant = CollectibleQuadrantEnums.FIRST;
        }
      }
    }
    return Future.value(isCoinRemoved);
  }

  Future<void> addWorldCollision() async {
    (await MapLoader.readRayWorldCollisionMap()).forEach((rect) async{
      _logger.log(_TAG, "Added collidable at $rect");
      await world.add(WorldCollidable()
        ..position = Vector2(rect.left, rect.top)
        ..width = rect.width
        ..height = rect.height);
    });
  }

  RectangleHitbox createWorldCollidable(Rect rect) {
    final collidable = RectangleHitbox();
    collidable.position = Vector2(rect.left, rect.top);
    collidable.width = rect.width;
    collidable.height = rect.height;
    return collidable;
  }

  @override
  void onDoubleTap() {
    if (running) {
      pauseEngine();
    } else {
      resumeEngine();
    }
    running = !running;
    _gameTriggers.addGamePauseOrResume(isGamePaused: running);
  }

  Future<void> speakMovement(GhostPositionModel ghostPositionModel, NotifyingVector2 enemyPosition ) async{
    String speakString = "";
    bool isPlayerRight = enemyPosition.x > _player.position.x;
    bool isPlayerDownwards =   enemyPosition.y > _player.position.y  ;
    if(ghostPositionModel.isXAxisMovement){
      if(ghostPositionModel.isLeft && isPlayerDownwards){
        speakString = LocaleKeys.game_enemy_down_left.tr(namedArgs: {
          'enemyName' : enemyName
        });
      }
      else if(ghostPositionModel.isLeft && !isPlayerDownwards){
        speakString = LocaleKeys.game_enemy_up_left.tr(namedArgs: {
          'enemyName' : enemyName
        });
      }
      else if(!ghostPositionModel.isLeft && isPlayerDownwards){
        speakString = LocaleKeys.game_enemy_down_right.tr(namedArgs: {
          'enemyName' : enemyName
        });
      }
      else if(!ghostPositionModel.isLeft && !isPlayerDownwards){
        speakString = LocaleKeys.game_enemy_up_right.tr(namedArgs: {
          'enemyName' : enemyName
        });
      }
    }
    else{
      if(ghostPositionModel.isDown && isPlayerRight){
        speakString = LocaleKeys.game_enemy_right_down.tr(namedArgs: {
          'enemyName' : enemyName
        });;
      }
      else if(ghostPositionModel.isDown && !isPlayerRight){
        speakString = LocaleKeys.game_enemy_left_down.tr(namedArgs: {
          'enemyName' : enemyName
        });;
      }
      else if(!ghostPositionModel.isDown && isPlayerRight){
        LocaleKeys.game_enemy_right_up.tr(namedArgs: {
          'enemyName' : enemyName
        });
      }
      else if(!ghostPositionModel.isDown && !isPlayerRight){
        speakString = LocaleKeys.game_enemy_left_up.tr(namedArgs: {
          'enemyName' : enemyName
        });
      }
    }
    _logger.log(_TAG, "Speak String $speakString");
    bool isSpeakComplete = await _visionTts.speakText(speakString);
    //bool isSpeakComplete = true;
    if(isSpeakComplete){
      bool isCoinRemoved = await addCoinInGame();
      if(isCoinRemoved == false){
        await speakCollectablePosition();
      }
    }
  }

  ///Position for collectable is only spoken when it is added in game
  Future<void> speakCollectablePosition() async{
    isPlayerMovementLocked = true;
    _player.isPlayerImmutable = true;
    bool isLeft = _player.position.x > _coins.x ;
    bool isUp = _player.position.y > _coins.y ;
    ///Below variables calculate how many places player has to move to reach to collectible
    int xPlaces =((_player.position.x - _coins.position.x) / (ApplicationConstants.deltaValue)).abs().round();
    int yPlaces =(((_player.position.y - _coins.position.y) / (ApplicationConstants.deltaValue))).abs().round();
    if(_coins.currentQuadrant == CollectibleQuadrantEnums.SECOND){
      if(xPlaces > 0){
        xPlaces = xPlaces - 1;
      }
      if(yPlaces > 0){
        yPlaces = yPlaces - 1;
      }
    }
    if(_coins.currentQuadrant == CollectibleQuadrantEnums.FIRST){
      if(yPlaces > 0){
        yPlaces = yPlaces - 1;
      }
    }
    //_logger.log(_TAG, "X places $xPlaces and y places $yPlaces");
    String coinPositionText;
    if(isUp){
      if(isLeft){
        coinPositionText = LocaleKeys.game_collectible_left_up.tr(namedArgs: {
          'collectibleMessage' : ApplicationConstants.collectibleMessage,
          'xPlaces' : xPlaces.toString(),
          'yPlaces' : yPlaces.toString()
        });
      }
      else{
        coinPositionText = LocaleKeys.game_collectible_right_up.tr(namedArgs: {
          'collectibleMessage' : ApplicationConstants.collectibleMessage,
          'xPlaces' : xPlaces.toString(),
          'yPlaces' : yPlaces.toString()
        });
      }
    }
    else{
      if(isLeft){
        coinPositionText = LocaleKeys.game_collectible_left_down.tr(namedArgs: {
          'collectibleMessage' : ApplicationConstants.collectibleMessage,
          'xPlaces' : xPlaces.toString(),
          'yPlaces' : yPlaces.toString()
        });
      }
      else{
        coinPositionText = LocaleKeys.game_collectible_right_down.tr(namedArgs: {
          'collectibleMessage' : ApplicationConstants.collectibleMessage,
          'xPlaces' : xPlaces.toString(),
          'yPlaces' : yPlaces.toString()
        });
      }
    }
    //_logger.log(_TAG, "Next collectible at $coinPositionText");
    //await _visionTts.speakStop();
    await _visionTts.speakText(coinPositionText);
    isPlayerMovementLocked = false;
  }

  void check(){
    _ghostPlayer.test();
  }

  /**
   * Generates a positive random integer uniformly distributed on the range
   * from [min], inclusive, to [max], exclusive.
   */
  int next(int min, int max) => min + _random.nextInt(max - min);
}