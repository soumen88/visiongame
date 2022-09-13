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
import 'package:visiongame/game/components/tutorial_player.dart';
import 'package:visiongame/game/components/vision_world.dart';
import 'package:visiongame/game/components/world_collidable.dart';
import 'package:visiongame/game/models/ghost_position_model.dart';
import 'package:visiongame/game/models/player_motion_model.dart';
import 'package:visiongame/game/triggers/game_triggers.dart';
import 'package:visiongame/injector/injection.dart';
import '../base/constants.dart';
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
  final TutorialPlayer _player = TutorialPlayer();

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

  void listenToGameSteps(){
    _gameTriggers.stepCounter.listen((int? stepValue) {
      if(stepValue != null){
        switch(stepValue){
          case 3:{
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
          case 5:{
            int randomX = next(50, 100);
            int randomY = next(50, 500);
            Future.delayed(Duration.zero, () async{
              await add(_ghostPlayer);
              _ghostPlayer.position = Vector2(camera.position.x + randomX, camera.position.y + randomY);
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

    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));

  }

  onArrowKeyChanged(Direction direction){
    int? currentStep = _gameTriggers.stepCounter.value;
    if(currentStep != null && currentStep == 1){
      _gameTriggers.addStepCounter(2);
    }
    _player.direction = direction;
    _player.updatePosition();
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

  Future<void> speakCollectablePosition() async{
    bool isLeft = _player.position.x > _coins.x ;
    bool isUp = _player.position.y > _coins.y ;
    ///Below variables calculate how many places player has to move to reach to collectible
    int xPlaces =((_player.position.x - _coins.position.x) ~/ (ApplicationConstants.deltaValue)).abs() ;
    int yPlaces =(((_player.position.y - _coins.position.y) ~/ (ApplicationConstants.deltaValue)) - 2).abs() ;
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

    await _visionTts.speakStop();
    await _visionTts.speakText(coinPositionText);
  }


  /**
   * Generates a positive random integer uniformly distributed on the range
   * from [min], inclusive, to [max], exclusive.
   */
  int next(int min, int max) => min + _random.nextInt(max - min);
}