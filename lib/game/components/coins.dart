import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:visiongame/enums/game_component_enums.dart';
import 'package:visiongame/game/components/player.dart';
import 'package:visiongame/injector/injection.dart';

import '../../audioplayer/game_audio_player.dart';
import '../../base/logger_utils.dart';
import '../../texttospeech/vision_text_to_speech_converter.dart';
import '../triggers/game_triggers.dart';
import '../triggers/game_tutorial_triggers.dart';

class Coins extends SpriteComponent with HasGameRef, CollisionCallbacks{

  final _TAG = "Coins";
  final _logger = locator<LoggerUtils>();
  final _gameTriggers = locator<GameTriggers>();
  final _gameTutorialTriggers = locator<GameTutorialTriggers>();
  final _gameAudioPlayer = locator<GameAudioPlayer>();
  final _visionTts = locator<VisionTextToSpeechConverter>();
  bool isRunning = true;
  String currentCollectable = "";
  final _random = Random();
  Coins()
      : super(
    size: Vector2.all(50.0),
  );


  @override
  Future<void> onLoad() async{
    currentCollectable = "Coin";
    sprite = await gameRef.loadSprite('coin.png');
    position = gameRef.size / 2;
    add(RectangleHitbox());
    ///Once this timer elapses then collectible image would be changed in game
    add(
        TimerComponent(
          period: 10,
          repeat: true,
          onTick: () async{
            await generateRandomCollectible();
          },
        )
    );
  }

  Future<void> generateRandomCollectible() async{
    int randomNumberGenerated = next(0, 110);
    if(randomNumberGenerated > 0 && randomNumberGenerated < 10 ){
      currentCollectable = "Bell Pepper";
      sprite = await gameRef.loadSprite('bell_pepper.png');
    }
    else if(randomNumberGenerated > 10 && randomNumberGenerated < 20){
      currentCollectable = "Cabbage";
      sprite = await gameRef.loadSprite('cabbage.png');
    }
    else if(randomNumberGenerated > 30 && randomNumberGenerated < 40){
      currentCollectable = "Carrot";
      sprite = await gameRef.loadSprite('carrot.png');
    }
    else if(randomNumberGenerated > 40 && randomNumberGenerated < 50){
      currentCollectable = "Corn";
      sprite = await gameRef.loadSprite('corn.png');
    }
    else if(randomNumberGenerated > 50 && randomNumberGenerated < 60){
      currentCollectable = "Egg plant";
      sprite = await gameRef.loadSprite('eggplant.png');
    }
    else if(randomNumberGenerated > 60 && randomNumberGenerated < 70){
      currentCollectable = "Mushroom";
      sprite = await gameRef.loadSprite('mushroom.png');
    }
    else if(randomNumberGenerated > 70 && randomNumberGenerated < 80){
      currentCollectable = "Carrot";
      sprite = await gameRef.loadSprite('carrot.png');
    }
    else if(randomNumberGenerated > 80 && randomNumberGenerated < 90){
      currentCollectable = "Strawberry";
      sprite = await gameRef.loadSprite('strawberry.png');
    }
    else if(randomNumberGenerated > 90 && randomNumberGenerated < 100){
      currentCollectable = "Tomato";
      sprite = await gameRef.loadSprite('tomato.png');
    }
    else{
      currentCollectable = "Watermelon";
      sprite = await gameRef.loadSprite('watermelon.png');
    }
  }

  @override
  void onMount() {
    // Runs every time that the component is added to the component tree.
    print(gameRef.size.y);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) async{
    if(other is Player){
      _logger.log(_TAG, "Now playing sound");
      if(_gameTutorialTriggers.isTutorialInProgress){
        int? currentStep = _gameTutorialTriggers.stepCounter.value;
        if(currentStep != null && currentStep == 3){
          _gameTutorialTriggers.addStepCounter(4);
        }
      }
      else{
        await _visionTts.speakStop();
        await _visionTts.speakText("You collected $currentCollectable");
        await _gameAudioPlayer.playGameSound(GameComponentEnums.COINS);
        _gameTriggers.addPlayerCoins(addCoins: true);
      }
      removeFromParent();
    }
  }

  /**
   * Generates a positive random integer uniformly distributed on the range
   * from [min], inclusive, to [max], exclusive.
   */
  int next(int min, int max) => min + _random.nextInt(max - min);
}