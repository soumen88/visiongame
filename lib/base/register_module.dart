import 'package:injectable/injectable.dart';
import 'package:visiongame/texttospeech/vision_text_to_speech_converter.dart';
import '../router/app_router.gr.dart';

@module
abstract class RegisterModule{
  @singleton
  AppRouter get appRouter => AppRouter();
}