import 'package:injectable/injectable.dart';
import '../game/triggers/game_triggers.dart';
import '../router/app_router.gr.dart';

@module
abstract class RegisterModule{
  @singleton
  AppRouter get appRouter => AppRouter();

  @injectable
  GameTriggers get gameTriggers => GameTriggers.instance;
}