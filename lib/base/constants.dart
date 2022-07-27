import 'package:flutter/material.dart';

class ApplicationConstants {
  static const APP_NAME = "Amaze";
  static int kSplashScreenTime = 1;//seconds
  static int kAnimationLoadTime = 1;//seconds
  static int kTimerLimit = 5;//seconds
  static int kSpeechTimerLimit = 7;//seconds
  static int kInitialPlayerLifes = 3;//seconds
  //This indicates the number of coins player has to collect in order to complete 1st level
  static int kLevelEasyCompletionCoins = 5;
  static int kLevelMediumCompletionCoins = 2;
  static int kLevelEasyWalkSpeed = 100;

  static int kGhostTimer  = 5;//seconds
  static String ScreenDifficulty  = "Difficulty";//seconds
  static String ScreenGame  = "GameScreen";//seconds
  static String PlayerName  = "Stalin";//seconds
  static String PermissionDeniedMessage  = "Permission Denied. Kindly allow permissions for us to proceed";

  static const splashBackgroundColor = Colors.lightGreen;
}