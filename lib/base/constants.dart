import 'package:flutter/material.dart';

class ApplicationConstants {

  static const APP_NAME = "Sahaaya";
  static int kSplashScreenTime = 3;//seconds
  static int kAnimationLoadTime = 1;//seconds
  static int kTimerLimit = 5;//seconds
  static int kSpeechTimerLimit = 7;//seconds
  static int kInitialPlayerLifes = 3;//player life's at beginning of each level
  //This indicates the number of coins player has to collect in order to complete 1st level
  static int kLevelEasyCompletionCoins = 1;
  static int kLevelMediumCompletionCoins = 3;
  static int kLevelHardCompletionCoins = 3;
  static int kLevelEasyWalkSpeed = 100;

  static int kGhostTimer  = 5;//seconds
  static String ScreenDifficulty  = "Difficulty";
  static String ScreenGame  = "GameScreen";
  static String PlayerName  = "Raaj";
  static String PermissionDeniedMessage  = "Permission Denied. Kindly allow permissions for us to proceed";
  static String edgeMessage  = "You have reached an edge. Changing direction to ";
  static String collectibleMessage  = " ";
  static String levelChangeMessage  = "Yay! You have cleared Level ";

  static const appBackgroundColor = Color.fromARGB(255, 11, 134, 119);
  static const splashBackgroundColor = Color.fromARGB(255, 236,232,226);
  static int deltaValue = 50;
  static double playerDeltaValue = 0.5;
  //static double playerDeltaValue = 3;

}