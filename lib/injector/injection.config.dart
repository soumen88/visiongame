// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../audioplayer/game_audio_player.dart' as _i4;
import '../base/logger_utils.dart' as _i7;
import '../base/register_module.dart' as _i11;
import '../game/triggers/game_triggers.dart' as _i5;
import '../game/triggers/game_tutorial_triggers.dart' as _i6;
import '../main.dart' as _i8;
import '../router/app_router.gr.dart' as _i3;
import '../texttospeech/vision_text_to_speech_converter.dart' as _i10;
import '../voiceinput/vision_speech_input.dart'
    as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.AppRouter>(registerModule.appRouter);
  gh.factory<_i4.GameAudioPlayer>(() => registerModule.gameAudioPlayer);
  gh.factory<_i5.GameTriggers>(() => registerModule.gameTriggers);
  gh.factory<_i6.GameTutorialTriggers>(
      () => registerModule.gameTutorialTriggers);
  gh.factory<_i7.LoggerUtils>(() => _i7.LoggerUtils());
  gh.factory<_i8.MyApp>(() => _i8.MyApp());
  gh.factory<_i9.VisionSpeechInput>(() => registerModule.visionSpeech);
  gh.factory<_i10.VisionTextToSpeechConverter>(
      () => _i10.VisionTextToSpeechConverter());
  return get;
}

class _$RegisterModule extends _i11.RegisterModule {}
