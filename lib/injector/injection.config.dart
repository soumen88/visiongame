// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../audioplayer/game_audio_player.dart' as _i8;
import '../base/logger_utils.dart' as _i5;
import '../base/register_module.dart' as _i11;
import '../game/triggers/game_triggers.dart' as _i6;
import '../game/triggers/game_tutorial_triggers.dart' as _i9;
import '../main.dart' as _i3;
import '../router/app_router.dart' as _i10;
import '../texttospeech/vision_text_to_speech_converter.dart' as _i4;
import '../voiceinput/vision_speech_input.dart' as _i7;

// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final registerModule = _$RegisterModule();
  gh.factory<_i3.MyApp>(() => _i3.MyApp());
  gh.factory<_i4.VisionTextToSpeechConverter>(
      () => _i4.VisionTextToSpeechConverter());
  gh.factory<_i5.LoggerUtils>(() => _i5.LoggerUtils());
  gh.factory<_i6.GameTriggers>(() => registerModule.gameTriggers);
  gh.factory<_i7.VisionSpeechInput>(() => registerModule.visionSpeech);
  gh.factory<_i8.GameAudioPlayer>(() => registerModule.gameAudioPlayer);
  gh.factory<_i9.GameTutorialTriggers>(
      () => registerModule.gameTutorialTriggers);
  gh.singleton<_i10.AppRouter>(() => registerModule.appRouter);
  return getIt;
}

class _$RegisterModule extends _i11.RegisterModule {}
