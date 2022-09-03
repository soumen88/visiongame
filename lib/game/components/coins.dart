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
  String collectableIconName = "";///PNG file name
  bool isVoiceEnabled = true;

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
            await spawnNewCollectible();
          },
        )
    );
  }

  ///Once mike icon is set to turn off position the speaking for enemy position would stop
  void listenToVoiceInputEnabled(){
    _gameTriggers.isVoiceInputEnabled.listen((bool? isInputEnabled) {
      if(isInputEnabled != null){
        isVoiceEnabled = isInputEnabled;
      }
    });
  }


  Future<void> spawnNewCollectible() async{
    String collectibleName = await generateRandomCollectible();
    _logger.log(_TAG, "Adding collectible as $collectibleName");
    sprite = await gameRef.loadSprite(collectableIconName);
  }

  Future<String> generateRandomCollectible() async{

    int randomNumberGenerated = next(0, 110);
    if(randomNumberGenerated > 0 && randomNumberGenerated < 10 ){
      currentCollectable = "Bell Pepper";
      collectableIconName = "bell_pepper.png";
    }
    else if(randomNumberGenerated > 10 && randomNumberGenerated < 20){
      currentCollectable = "Cabbage";
      collectableIconName = "cabbage.png";
    }
    else if(randomNumberGenerated > 30 && randomNumberGenerated < 40){
      currentCollectable = "Carrot";
      collectableIconName = "carrot.png";
    }
    else if(randomNumberGenerated > 40 && randomNumberGenerated < 50){
      currentCollectable = "Corn";
      collectableIconName = "corn.png";
    }
    else if(randomNumberGenerated > 50 && randomNumberGenerated < 60){
      currentCollectable = "Lentil";
      collectableIconName = "lentil.png";
    }
    else if(randomNumberGenerated > 60 && randomNumberGenerated < 70){
      currentCollectable = "Mushroom";
      collectableIconName = "mushroom.png";
    }
    else if(randomNumberGenerated > 70 && randomNumberGenerated < 80){
      currentCollectable = "Carrot";
      collectableIconName = "carrot.png";
    }
    else if(randomNumberGenerated > 80 && randomNumberGenerated < 90){
      currentCollectable = "Strawberry";
      collectableIconName = "strawberry.png";
    }
    else if(randomNumberGenerated > 90 && randomNumberGenerated < 100){
      currentCollectable = "Tomato";
      collectableIconName = "tomato.png";
    }
    else{
      currentCollectable = "Watermelon";
      collectableIconName = "watermelon.png";
    }

    return Future.value(currentCollectable);
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
        await _gameAudioPlayer.playGameSound(GameComponentEnums.COINS);
        if(currentStep != null && currentStep == 3){
          _gameTutorialTriggers.addStepCounter(4);
        }
      }
      else{
        if(isVoiceEnabled){

          await _visionTts.speakStop()
              .then((value) {
                  _visionTts.speakText("Yay! You collected $currentCollectable");
              }).then((value){
                  _gameAudioPlayer.playGameSound(GameComponentEnums.COINS);
              }).then((value) {
                spawnNewCollectible();
          });
        }

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