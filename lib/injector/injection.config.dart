// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../base/logger_utils.dart' as _i5;
import '../base/register_module.dart' as _i9;
import '../game/triggers/game_triggers.dart' as _i4;
import '../main.dart' as _i6;
import '../router/app_router.gr.dart' as _i3;
import '../texttospeech/vision_text_to_speech_converter.dart' as _i8;
import '../voiceinput/vision_speech_input.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.singleton<_i3.AppRouter>(registerModule.appRouter);
  gh.factory<_i4.GameTriggers>(() => registerModule.gameTriggers);
  gh.factory<_i5.LoggerUtils>(() => _i5.LoggerUtils());
  gh.factory<_i6.MyApp>(() => _i6.MyApp());
  gh.factory<_i7.VisionSpeechInput>(() => registerModule.visionSpeech);
  gh.factory<_i8.VisionTextToSpeechConverter>(
      () => _i8.VisionTextToSpeechConverter());
  return get;
}

class _$RegisterModule extends _i9.RegisterModule {}
