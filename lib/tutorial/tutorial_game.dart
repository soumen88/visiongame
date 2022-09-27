import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:visiongame/enums/player_life_status_enums.dart';
import 'package:visiongame/enums/tutorial_step_enums.dart';
import 'package:visiongame/game/components/coins.dart';
import 'package:visiongame/game/components/enemy_dragon.dart';
import 'package:visiongame/game/components/ghost.dart';
import 'package:visiongame/game/components/hearts.dart';
import 'package:visiongame/game/components/moth.dart';
import 'package:visiongame/game/components/tutorial_ghost.dart';
import 'package:visiongame/game/components/tutorial_player.dart';
import 'package:visiongame/game/components/vision_world.dart';
import 'package:visiongame/game/components/world_collidable.dart';
import 'package:visiongame/game/models/ghost_position_model.dart';
import 'package:visiongame/game/models/player_motion_model.dart';
import 'package:visiongame/game/triggers/game_triggers.dart';
import 'package:visiongame/injector/injection.dart';
import '../base/constants.dart';
import '../base/logger_utils.dart';
import '../enums/collectible_quadrant_enums.dart';
import '../enums/difficulty_level_enum.dart';
import '../game/components/player.dart';
import '../game/helpers/direction.dart';
import '../game/helpers/map_loader.dart';
import '../game/triggers/game_tutorial_triggers.dart';
import '../texttospeech/vision_text_to_speech_converter.dart';

/// This class encapulates the whole game.
class TutorialGame extends FlameGame with HasCollisionDetection, DoubleTapDetector{
  final _logger = locator<LoggerUtils>();
  final _TAG = "VisionGame";
  final TutorialPlayer _player = TutorialPlayer();

  final EnemyDragon _dragon = EnemyDragon();
  final TutorialGhost _ghostPlayer = TutorialGhost();
  late Moth _moth;

  final VisionWorld _world = VisionWorld();
  ///Game Collectables
  final Hearts _hearts = Hearts();
  final Coins _coins = Coins();

  int screenHeight;
  int screenWidth;
  bool running = true;
  final _gameTriggers = locator<GameTutorialTriggers>();
  final _random = Random();
  bool isVoiceEnabled = true;
  ///Below variable is used for speaking about ghost position in the game
  final _visionTts = locator<VisionTextToSpeechConverter>();
  ///If below variable is true then player cannot move
  bool isPlayerMovementLocked = false;
  ///In tutorial there will only be one enemy that is ghost
  String enemyName = "Ghost";
  ///If collectible is not picked within this counter time then it would be removed
  ///and then a new collectible will be added
  int collectibleCounter = 3;


  TutorialGame({required this.screenWidth, required this.screenHeight}){
    listenToGhostMovement();
    listenToVoiceInputEnabled();
    listenToGameSteps();
  }


  ///Once mike icon is set to turn off position the speaking for enemy position would stop
  void listenToVoiceInputEnabled(){
    _gameTriggers.isVoiceInputEnabled.listen((bool? isInputEnabled) {
      if(isInputEnabled != null){
        isVoiceEnabled = isInputEnabled;
      }
    });
  }

  void listenToGhostMovement() {
    _ghostPlayer.ghostPositionNotifierTutorial.listen((GhostPositionModel? ghostPositionModel) async {
      if (ghostPositionModel != null && running) {
        int randomX = next(50, 400);
        int randomY = next(50, 400);
        _logger.log(_TAG, "Dragon position ${_dragon.position}");
        _ghostPlayer.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
        TutorialStepEnums? currentStep = _gameTriggers.stepCounter.value;
        if (currentStep == TutorialStepEnums.SPAWN_COIN) {
          await speakMovement(ghostPositionModel, _ghostPlayer.position);
        }
      }
    });
  }

  void listenToGameSteps(){
    _gameTriggers.stepCounter.listen((TutorialStepEnums? stepValue) {
      if(stepValue != null){
        switch(stepValue){
          case TutorialStepEnums.SPAWN_COIN:{
            int randomX = 3;
            int randomY = 5;
            //Remove current coin and add another one
            _coins.removeFromParent();
            Future.delayed(Duration.zero, () async{
              if(running &&  !_coins.isMounted){
                await add(_coins);
                _coins.position = Vector2(_player.position.x + (randomX * ApplicationConstants.deltaValue), _player.position.y + (randomY * ApplicationConstants.deltaValue)) ;
                await speakCollectablePosition();
              }
            });
          }
          break;
          case TutorialStepEnums.SPAWN_GHOST:{
            int randomX = next(50, 100);
            int randomY = next(50, 500);
            Future.delayed(Duration.zero, () async{
              await add(_ghostPlayer);
              _ghostPlayer.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
            });
            _gameTriggers.addStepCounter(TutorialStepEnums.START_COIN_INTRODUCTION);
          }
          break;
          default:{
            break;
          }
        }
      }
    });
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    _logger.log(_TAG, "inside on load");

    await add(_world);
    await add(_player);
    _player.position = _world.size / 1.5;
    addWorldCollision();

    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));

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
      await add(_coins);

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

  onArrowKeyChanged(Direction direction){
    TutorialStepEnums? currentStep = _gameTriggers.stepCounter.value;
    if(currentStep != null && currentStep == TutorialStepEnums.START_TUTORIAL_VIEW){
      _gameTriggers.addStepCounter(TutorialStepEnums.START_GHOST_INTRODUCTION);
    }
    if(isPlayerMovementLocked == false){
      _player.direction = direction;
      _player.updatePosition();
    }

  }

  TutorialPlayer get getPlayer {
    return _player;
  }

  void addWorldCollision() async =>
      (await MapLoader.readRayWorldCollisionMap()).forEach((rect) {
        add(WorldCollidable()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });

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
    bool isRight = enemyPosition.x > _player.position.x;
    if(ghostPositionModel.isXAxisMovement){
      if(isRight){
        speakString = "$enemyName coming from right";
      }
      else{
        speakString = "$enemyName coming from left";
      }
    }
    else{
      if(ghostPositionModel.isDown && isRight){
        speakString = "$enemyName coming from right and walking down";
      }
      else if(ghostPositionModel.isDown && !isRight){
        speakString = "$enemyName coming from left and walking down";
      }
      else if(!ghostPositionModel.isDown && isRight){
        speakString = "$enemyName coming from right and walking up";
      }
      else if(!ghostPositionModel.isDown && !isRight){
        speakString = "$enemyName coming from left and walking up";
      }
    }
    _logger.log(_TAG, "Speak String $speakString");
    bool isSpeakComplete = await _visionTts.speakText(speakString);
    //bool isSpeakComplete = true;
    if(isSpeakComplete){
      //await _coins.generateRandomCollectible();
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
        coinPositionText = "${ApplicationConstants.collectibleMessage} is ${xPlaces} left and ${yPlaces} upwards";
      }
      else{
        coinPositionText = "${ApplicationConstants.collectibleMessage} is ${xPlaces} right and ${yPlaces} upwards";
      }
    }
    else{
      if(isLeft){
        coinPositionText = "${ApplicationConstants.collectibleMessage} is ${xPlaces} left and ${yPlaces} downwards";
      }
      else{
        coinPositionText = "${ApplicationConstants.collectibleMessage} is ${xPlaces} right and ${yPlaces} downwards";
      }
    }
    _logger.log(_TAG, "Next collectible at $coinPositionText");
    //await _visionTts.speakStop();
    await _visionTts.speakText(coinPositionText);
    isPlayerMovementLocked = false;
  }

  /**
   * Generates a positive random integer uniformly distributed on the range
   * from [min], inclusive, to [max], exclusive.
   */
  int next(int min, int max) => min + _random.nextInt(max - min);
}