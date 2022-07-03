import 'package:flame/game.dart';
import 'package:visiongame/enums/player_life_status_enums.dart';

///Below class is used to notify game view of different player events
class PlayerMotionModel{

  PlayerLifeStatusEnums event;
  ///Saving position of the player when it was alive and when it was dead
  Vector2 position;
  ///Track how many lives player has in the game
  int playerLivesLeft;

  PlayerMotionModel({required this.event, required this.position, required this.playerLivesLeft});

  @override
  String toString() {
    return 'PlayerMotionModel{event: $event, position: $position, playerLivesLeft: $playerLivesLeft}';
  }
}