import 'dart:math';
import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:visiongame/enums/player_life_status_enums.dart';
import 'package:visiongame/game/components/coins.dart';
import 'package:visiongame/game/components/enemy_dragon.dart';
import 'package:visiongame/game/components/ghost.dart';
import 'package:visiongame/game/components/hearts.dart';
import 'package:visiongame/game/components/moth.dart';
import 'package:visiongame/game/components/vision_world.dart';
import 'package:visiongame/game/components/world_collidable.dart';
import 'package:visiongame/game/models/ghost_position_model.dart';
import 'package:visiongame/game/models/player_motion_model.dart';
import 'package:visiongame/game/triggers/game_triggers.dart';
import 'package:visiongame/injector/injection.dart';
import '../base/logger_utils.dart';
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
  final Player _player = Player();

  final EnemyDragon _dragon = EnemyDragon();
  final Ghost _ghostPlayer = Ghost();
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

  TutorialGame({required this.screenWidth, required this.screenHeight}){
    listenPlayerDead();
    listenToGhostMovement();
    listenToVoiceInputEnabled();
    listenToDifficultyLevelChanges();
    listenToGameSteps();
  }

  void listenPlayerDead(){
    _gameTriggers.playerLifeEventNotifier.listen((PlayerMotionModel? playerMotionModel) {
      if(playerMotionModel != null && playerMotionModel.event == PlayerLifeStatusEnums.PLAYER_NEW_LIFE){
        Future.delayed(Duration(seconds: 2), () async{
          _player.position = playerMotionModel.position;
          await add(_player);
        });
      }
    });
  }

  ///This function would work with all types of villains like ghost, dragon and moth
  void listenToGhostMovement(){
    _ghostPlayer.ghostPositionNotifier.listen((GhostPositionModel? ghostPositionModel) async{
      if(ghostPositionModel != null && running){
        int randomX = next(50, 400);
        int randomY = next(50, 400);
        DifficultyLevelEnums currentDifficultyLevel = _gameTriggers.gameDifficultyLevelStream.value!;
        if(currentDifficultyLevel == DifficultyLevelEnums.EASY){
          _ghostPlayer.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
        }
        else if(currentDifficultyLevel == DifficultyLevelEnums.MEDIUM){
          _dragon.direction = DirectionEnumsExt.generateRandomUniqueDirection();
          _dragon.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
        }
        if(isVoiceEnabled){
          await speakMovement(ghostPositionModel);
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
  void listenToDifficultyLevelChanges() async{
    _gameTriggers.gameDifficultyLevelStream.listen((DifficultyLevelEnums? currentDifficultyLevel) async{
      if(currentDifficultyLevel != null){
        _gameTriggers.addPlayerCoins(isInitial: true, addCoins: false);
        if(currentDifficultyLevel == DifficultyLevelEnums.EASY){
          _logger.log(_TAG, "Received event for easy level");
          await add(_ghostPlayer);
          _ghostPlayer.position = _world.size / 1.6;
        }
        else if(currentDifficultyLevel == DifficultyLevelEnums.MEDIUM){
          _logger.log(_TAG, "Received event for medium level");
          _ghostPlayer.removeFromParent();

          int randomX = next(50, 400);
          int randomY = next(50, 400);
          await add(_dragon);
          _dragon.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
        }
        else if(currentDifficultyLevel == DifficultyLevelEnums.HARD){
          final componentSize = Vector2(150, 100);
          _moth = Moth(Vector2.all(60), Vector2.all(100), componentSize);
          int randomX = next(50, 400);
          int randomY = next(50, 400);
          await add(_moth);
          _moth.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
        }
      }
    });
  }

  void listenToGameSteps(){
    _gameTriggers.stepCounter.listen((int? stepValue) {
      if(stepValue != null){
        switch(stepValue){
          case 3:{
            int randomX = next(50, 100);
            int randomY = next(50, 500);
            //Remove current coin and add another one
            _coins.removeFromParent();
            Future.delayed(Duration.zero, () async{
              if(running &&  !_coins.isMounted){
                await add(_coins);
                _coins.position = Vector2(camera.position.x + randomX, camera.position.y + randomY) ;
              }
            });
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

    _gameTriggers.setDifficultyLevel(DifficultyLevelEnums.EASY);
    _gameTriggers.addPlayerEvent(PlayerLifeStatusEnums.PLAYER_INIT, _player.position, isInitial: true);

    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));


    final Stream<int> _heartPositionStream = Stream.periodic(const Duration(seconds: 5), (int count) {
      return count;
    }).takeWhile((element) => running);


    _heartPositionStream.listen((int event) {
      int randomX = next(50, 400);
      int randomY = next(50, 1000);
      //Remove current heart and add another one
      _hearts.removeFromParent();
      Future.delayed(Duration.zero,() async{
        if(running && !_hearts.isMounted){
          await add(_hearts);
          _hearts.position = Vector2(camera.position.x + randomX, camera.position.y + randomY) ;
        }
      });
    });
  }

  onArrowKeyChanged(Direction direction){
    int? currentStep = _gameTriggers.stepCounter.value;
    if(currentStep != null && currentStep == 1){
      _gameTriggers.addStepCounter(2);
    }
    _player.direction = direction;
  }

  Player get getPlayer {
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

  Future<void> speakMovement(GhostPositionModel ghostPositionModel) async{
    String speakString = "";
    bool isRight = _ghostPlayer.position.x > _player.position.x;
    if(ghostPositionModel.isXAxisMovement){
      if(isRight){
        speakString = "Enemy coming from right";
      }
      else{
        speakString = "Enemy coming from left";
      }
    }
    else{
      if(ghostPositionModel.isDown && isRight){
        speakString = "Enemy coming from right and walking down";
      }
      else if(ghostPositionModel.isDown && !isRight){
        speakString = "Enemy coming from left and walking down";
      }
      else if(!ghostPositionModel.isDown && isRight){
        speakString = "Enemy coming from right and walking up";
      }
      else if(!ghostPositionModel.isDown && !isRight){
        speakString = "Enemy coming from left and walking up";
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