import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:visiongame/enums/player_life_status_enums.dart';
import 'package:visiongame/game/components/coins.dart';
import 'package:visiongame/game/components/ghost.dart';
import 'package:visiongame/game/components/hearts.dart';
import 'package:visiongame/game/components/vision_world.dart';
import 'package:visiongame/game/components/world_collidable.dart';
import 'package:visiongame/game/models/player_motion_model.dart';
import 'package:visiongame/game/triggers/game_triggers.dart';
import 'package:visiongame/injector/injection.dart';
import '../base/logger_utils.dart';
import 'components/player.dart';
import 'helpers/direction.dart';
import 'helpers/map_loader.dart';

/// This class encapulates the whole game.
class VisionGame extends FlameGame with HasCollisionDetection, DoubleTapDetector{
  final _logger = locator<LoggerUtils>();
  final _TAG = "VisionGame";
  final Player _player = Player();
  final Ghost _ghostPlayer = Ghost();
  final Hearts _hearts = Hearts();
  final VisionWorld _world = VisionWorld();
  final Coins _coins = Coins();
  bool running = true;
  final _gameTriggers = locator<GameTriggers>();
  var _random = Random();

  VisionGame(){
    listenPlayerDead();
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

  Future<void> addNewPlayer() async{
    await add(_player);

  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(_world);
    await add(_player);
    await add(_ghostPlayer);
    addWorldCollision();
    _player.position = _world.size / 1.5;
    _gameTriggers.addPlayerEvent(PlayerLifeStatusEnums.PLAYER_INIT, _player.position, isInitial: true);
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));

    _ghostPlayer.position = _world.size / 1.6;

    final Stream<int> _ghostPositionStream = Stream.periodic(const Duration(seconds: 5), (int count) {
      return count;
    }).takeWhile((element) => running);

    final Stream<int> _coinPositionStream = Stream.periodic(const Duration(seconds: 5), (int count) {
      return count;
    }).takeWhile((element) => running);

    final Stream<int> _heartPositionStream = Stream.periodic(const Duration(seconds: 5), (int count) {
      return count;
    }).takeWhile((element) => running);

    _ghostPositionStream.listen((int event) {
      //_ghostPlayer.position = camera.position;
      int randomX = next(50, 100);
      int randomY = next(50, 100);
      _logger.log(_TAG, "Random x $randomX");
      _ghostPlayer.switchDirection();
      _ghostPlayer.position = Vector2(camera.position.x + randomX, camera.position.y + randomY) ;
    });

    _coinPositionStream.listen((int event)  async{
      int randomX = next(50, 100);
      int randomY = next(50, 500);
      if(!_coins.isMounted){
        await add(_coins);
        _coins.position = Vector2(camera.position.x + randomX, camera.position.y + randomY) ;
      }
    });

    _heartPositionStream.listen((int event)  async{
      if(!_hearts.isMounted){
        int randomX = next(50, 400);
        int randomY = next(50, 1000);
        await add(_hearts);
        _hearts.position = Vector2(camera.position.x + randomX, camera.position.y + randomY) ;
      }

    });
  }

  onArrowKeyChanged(Direction direction){
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

  /**
   * Generates a positive random integer uniformly distributed on the range
   * from [min], inclusive, to [max], exclusive.
   */
  int next(int min, int max) => min + _random.nextInt(max - min);
}