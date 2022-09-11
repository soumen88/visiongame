import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:visiongame/base/constants.dart';
import 'package:visiongame/enums/player_life_status_enums.dart';
import 'package:visiongame/game/components/coins.dart';
import 'package:visiongame/game/components/enemy_dragon.dart';
import 'package:visiongame/game/components/ghost.dart';
import 'package:visiongame/game/components/hearts.dart';
import 'package:visiongame/game/components/animated_component.dart';
import 'package:visiongame/game/components/moth.dart';
import 'package:visiongame/game/components/ninja_girl.dart';
import 'package:visiongame/game/components/vision_world.dart';
import 'package:visiongame/game/components/world_collidable.dart';
import 'package:visiongame/game/models/ghost_position_model.dart';
import 'package:visiongame/game/models/player_motion_model.dart';
import 'package:visiongame/game/triggers/game_triggers.dart';
import 'package:visiongame/injector/injection.dart';
import '../base/logger_utils.dart';
import '../enums/difficulty_level_enum.dart';
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
          await add(_player);
          _gameTriggers.setImmutability();
        });
      }
      else if(playerMotionModel != null && playerMotionModel.event == PlayerLifeStatusEnums.PLAYER_CHANGE_DIRECTION){
        changePlayerWalkDirection(shouldSpeakDirection: true);
      }
    });
  }

  void changePlayerWalkDirection({bool shouldSpeakDirection = false}) async{
    ///Reversing the direction of player when he spawns again into game
    switch(_player.direction){
      case Direction.down:{
        _player.direction = Direction.up;
        if(shouldSpeakDirection){
          await _visionTts.speakStop();
          await _visionTts.speakText("${ApplicationConstants.edgeMessage} upwards.");
        }
      }
      break;
      case Direction.up :{
        _player.direction = Direction.down;
        if(shouldSpeakDirection){
          await _visionTts.speakStop();
          await _visionTts.speakText("${ApplicationConstants.edgeMessage} downwards.");
        }
      }
      break;
      case Direction.right :{
        _player.direction = Direction.left;
        if(shouldSpeakDirection){
          await _visionTts.speakStop();
          await _visionTts.speakText("${ApplicationConstants.edgeMessage} left.");
        }
      }
      break;
      case Direction.left :{
        _player.direction = Direction.right;
        if(shouldSpeakDirection){
          await _visionTts.speakStop();
          await _visionTts.speakText("${ApplicationConstants.edgeMessage} right.");
        }
      }
      break;
      case Direction.none :{
        _player.direction = Direction.right;
        if(shouldSpeakDirection){
          await _visionTts.speakStop();
          await _visionTts.speakText("${ApplicationConstants.edgeMessage} right.");
        }
      }
      break;
    }

  }

  ///This function would work with all types of villains like ghost, dragon and moth
  void listenToGhostMovement(){
    _ghostPlayer.ghostPositionNotifier.listen((GhostPositionModel? ghostPositionModel) async{
      if(ghostPositionModel != null && running){
        int randomX = next(50, 400);
        int randomY = next(50, 400);
        _logger.log(_TAG, "Dragon position ${_dragon.position}");
        _ghostPlayer.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
        if(isVoiceEnabled){
          await speakMovement(ghostPositionModel, _ghostPlayer.position);
        }
      }
    });

    _dragon.dragonPositionNotifier.listen((GhostPositionModel? dragonPositionModel) async{
      if(dragonPositionModel != null && running){
        int randomX = next(50, 400);
        int randomY = next(50, 400);
        _dragon.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
        if(isVoiceEnabled){
          await speakMovement(dragonPositionModel, _dragon.position);
        }
      }
    });

   _ninjaGirl.ninjaPositionNotifier.listen((GhostPositionModel? ninjaPositionModel) async{
     if(ninjaPositionModel != null && running){
       int randomX = next(50, 400);
       int randomY = next(50, 400);
       _ninjaGirl.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
       if(isVoiceEnabled){
         await speakMovement(ninjaPositionModel, _ninjaGirl.position);
       }
     }
   });
  }

  ///Once mike icon is set to turn off position the speaking for enemy position would stop
  void listenToVoiceInputEnabled(){
    _gameTriggers.isVoiceInputEnabled.listen((bool? isInputEnabled) {
      if(isInputEnabled != null){
        isVoiceEnabled = isInputEnabled;
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
          _dragon.removeFromParent();
          _ninjaGirl.removeFromParent();
          _ghostPlayer.position = _world.size / 1.6;
        }
        else if(currentDifficultyLevel == DifficultyLevelEnums.MEDIUM){
          _logger.log(_TAG, "Received event for medium level");
          _ghostPlayer.removeFromParent();
          enemyName = "Dragon";
          await _visionTts.speakStop();
          await _visionTts.speakText("You have moved to Level Medium.Enemy changes to $enemyName");
          int randomX = next(50, 400);
          int randomY = next(50, 400);
          await add(_dragon);
          _dragon.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
        }
        else if(currentDifficultyLevel == DifficultyLevelEnums.HARD){
          _logger.log(_TAG, "Received event for hard level");
          _dragon.removeFromParent();
          enemyName = "Ninja Girl";
          /*final componentSize = Vector2(150, 100);
          _moth = Moth(Vector2.all(60), Vector2.all(100), componentSize);*/
          int randomX = next(50, 400);
          int randomY = next(50, 400);
          await _visionTts.speakStop();
          await _visionTts.speakText("You have moved to Level Hard.Enemy changes to $enemyName");
          //listenToMothMovement();
          /*await add(_moth);
          _moth.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);*/
          await add(_ninjaGirl);
          _ninjaGirl.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
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
    await addWorldCollision();
    await add(_ghostPlayer);
    _gameTriggers.setDifficultyLevel(DifficultyLevelEnums.EASY);

    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));

    /*final Stream<int> _coinPositionStream = Stream.periodic(const Duration(seconds: 5), (int count) {
      return count;
    }).takeWhile((element) => running);

    final Stream<int> _heartPositionStream = Stream.periodic(const Duration(seconds: 5), (int count) {
      return count;
    }).takeWhile((element) => running);

    _heartPositionStream.listen((int event) async{

    });*/
    //await _ghostPlayer.addGhostMotion();
  }

  onArrowKeyChanged(Direction direction){
    _player.direction = direction;
  }

  Player get getPlayer {
    return _player;
  }

  Future<bool> addCoinInGame() async{
    bool isCoinRemoved = false;
    int randomX = next(50, 100);
    int randomY = next(50, 500);
    if(_coins.isMounted){
      _logger.log(_TAG, "remove coin on purpose");
      isCoinRemoved = true;
      _coins.removeFromParent();
    }
    if(running &&  !_coins.isMounted){
      isCoinRemoved = false;
      await add(_coins);
      _coins.position = Vector2(camera.position.x + randomX, camera.position.y + randomY) ;
    }
    return Future.value(isCoinRemoved);
  }

  Future<void> addWorldCollision() async {
    (await MapLoader.readRayWorldCollisionMap()).forEach((rect) {
      add(WorldCollidable()
        ..position = Vector2(rect.left, rect.top)
        ..width = rect.width
        ..height = rect.height);
    });
  }

  void check(){
    _dragon.checkisenabled();
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
    bool isLeft = _player.position.x > _coins.x ;
    bool isUp = _player.position.y > _coins.y ;
    String coinPositionText = "";
    if(isUp){
      if(isLeft){
        coinPositionText = "Collectable is to your left and upwards";
      }
      else{
        coinPositionText = "Collectable is to your right and upwards";
      }
    }
    else{
      if(isLeft){
        coinPositionText = "Collectable is to your left and downwards";
      }
      else{
        coinPositionText = "Collectable is to your right and downwards";
      }
    }

    await _visionTts.speakStop();
    await _visionTts.speakText(coinPositionText);
  }

  /**
   * Generates a positive random integer uniformly distributed on the range
   * from [min], inclusive, to [max], exclusive.
   */
  int next(int min, int max) => min + _random.nextInt(max - min);
}