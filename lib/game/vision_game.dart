import 'package:flame/game.dart';

import 'components/player.dart';

/// This class encapulates the whole game.
class VisionGame extends FlameGame{
  final Player _player = Player();

  @override
  Future<void> onLoad() async {
    add(_player);
    return super.onLoad();
  }
}