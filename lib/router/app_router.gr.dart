// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../game/main_game_screen.dart' as _i3;
import '../home/home_screen.dart' as _i2;
import '../splash/splash_screen.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    SplashScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.SplashScreenPage());
    },
    HomeScreenRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.HomeScreenPage());
    },
    MainGameRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.MainGamePage());
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig('/#redirect',
            path: '/', redirectTo: '/splash', fullMatch: true),
        _i4.RouteConfig(SplashScreenRoute.name, path: '/splash'),
        _i4.RouteConfig(HomeScreenRoute.name, path: '/home'),
        _i4.RouteConfig(MainGameRoute.name, path: '/gameScreen')
      ];
}

/// generated route for
/// [_i1.SplashScreenPage]
class SplashScreenRoute extends _i4.PageRouteInfo<void> {
  const SplashScreenRoute() : super(SplashScreenRoute.name, path: '/splash');

  static const String name = 'SplashScreenRoute';
}

/// generated route for
/// [_i2.HomeScreenPage]
class HomeScreenRoute extends _i4.PageRouteInfo<void> {
  const HomeScreenRoute() : super(HomeScreenRoute.name, path: '/home');

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i3.MainGamePage]
class MainGameRoute extends _i4.PageRouteInfo<void> {
  const MainGameRoute() : super(MainGameRoute.name, path: '/gameScreen');

  static const String name = 'MainGameRoute';
}
