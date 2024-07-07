import 'package:auto_route/auto_route.dart';

import '../difficultylevel/difficulty_level.dart';
import '../game/main_game_screen.dart';
import '../home/home_screen.dart';
import '../splash/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter{
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: "/splash",
      initial: true,
      page: SplashRoute.page,
    ),
    AutoRoute(
      path: "/home",
      page: HomeRoute.page,
    ),
    AutoRoute(
      path: "/difficultylevel",
      page: DifficultyLevelRoute.page,
    ),
    AutoRoute(
      path: "/gameScreen",
      page: MainGameRoute.page,
    ),
  ];
}
