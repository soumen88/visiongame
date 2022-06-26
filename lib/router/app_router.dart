

import 'package:auto_route/auto_route.dart';
import 'package:visiongame/splash/splash_screen.dart';

import '../game/main_game_screen.dart';
import '../home/home_screen.dart';

@MaterialAutoRouter(
    replaceInRouteName:'Page,Route',
    routes: [
      AutoRoute(
        path: "/splash",
        initial: true,
        page: SplashScreenPage,
      ),
      AutoRoute(
        path: "/home",
        page: HomeScreenPage,
      ),
      AutoRoute(
        path: "/gameScreen",
        page: MainGamePage,
      ),
    ]
)

class $AppRouter{

}