// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;

import '../difficultylevel/difficulty_level.dart' as _i3;
import '../game/main_game_screen.dart' as _i4;
import '../home/home_screen.dart' as _i2;
import '../splash/splash_screen.dart' as _i1;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashScreenPage());
    },
    HomeScreenRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.HomeScreenPage());
    },
    DifficultyLevelScreen.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.DifficultyLevelScreen());
    },
    MainGameRoute.name: (routeData) {
      return _i5.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.MainGamePage());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig('/#redirect',
            path: '/', redirectTo: '/splash', fullMatch: true),
        _i5.RouteConfig(SplashScreenRoute.name, path: '/splash'),
        _i5.RouteConfig(HomeScreenRoute.name, path: '/home'),
        _i5.RouteConfig(DifficultyLevelScreen.name, path: '/difficultylevel'),
        _i5.RouteConfig(MainGameRoute.name, path: '/gameScreen')
      ];
}

/// generated route for
/// [_i1.SplashScreenPage]
class SplashScreenRoute extends _i5.PageRouteInfo<void> {
  const SplashScreenRoute() : super(SplashScreenRoute.name, path: '/splash');

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [_i2.HomeScreenPage]
class HomeScreenRoute extends _i5.PageRouteInfo<void> {
  const HomeScreenRoute() : super(HomeScreenRoute.name, path: '/home');

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i3.DifficultyLevelScreen]
class DifficultyLevelScreen extends _i5.PageRouteInfo<void> {
  const DifficultyLevelScreen()
      : super(DifficultyLevelScreen.name, path: '/difficultylevel');

  static const String name = 'DifficultyLevelScreen';
}

/// generated route for
/// [_i4.MainGamePage]
class MainGameRoute extends _i5.PageRouteInfo<void> {
  const MainGameRoute() : super(MainGameRoute.name, path: '/gameScreen');

  static const String name = 'MainGameRoute';
}
