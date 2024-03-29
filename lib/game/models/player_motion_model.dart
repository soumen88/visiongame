import 'package:flame/game.dart';
import 'package:visiongame/base/constants.dart';
import 'package:visiongame/enums/player_life_status_enums.dart';
import 'package:visiongame/injector/injection.dart';

import '../../base/logger_utils.dart';

///Below class is used to notify game view of different player events
class PlayerMotionModel{

  final _TAG = "PlayerMotionModel";
  final _logger = locator<LoggerUtils>();

  PlayerLifeStatusEnums event;
  ///Saving position of the player when it was alive and when it was dead
  Vector2? position;
  ///Track how many lives player has in the game
  int playerLivesLeft;

  PlayerMotionModel({required this.event, required this.position, required this.playerLivesLeft});

  @override
  String toString() {
    return 'PlayerMotionModel{event: $event, position: $position, playerLivesLeft: $playerLivesLeft}';
  }
}