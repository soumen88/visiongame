import 'package:injectable/injectable.dart';
import 'package:visiongame/audioplayer/game_audio_player.dart';
import 'package:visiongame/game/triggers/game_tutorial_triggers.dart';
import 'package:visiongame/voiceinput/vision_speech_input.dart';
import '../game/triggers/game_triggers.dart';
import '../router/app_router.dart';

@module
abstract class RegisterModule{
  @singleton
  AppRouter get appRouter => AppRouter();

  @injectable
  GameTriggers get gameTriggers => GameTriggers.instance;

  @injectable
  VisionSpeechInput get visionSpeech => VisionSpeechInput.instance;

  @injectable
  GameAudioPlayer get gameAudioPlayer => GameAudioPlayer.instance;

  @injectable
  GameTutorialTriggers get gameTutorialTriggers => GameTutorialTriggers.instance;
}