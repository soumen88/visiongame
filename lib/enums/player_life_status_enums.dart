enum PlayerLifeStatusEnums{
  PLAYER_INIT,///This event is passed when player is added newly into the game
  PLAYER_NEW_LIFE,///This event is passed when player was killed and added because his lives where remaining
  PLAYER_DEAD,///This event is passed when player is dead
  PLAYER_GAME_OVER,///This event is passed when player has exhausted all his lives
  PLAYER_ADD_LIFE,///This event is passed when player collects hearts in the game
  PLAYER_GAME_WIN,///This event is passed when player wins in game
}