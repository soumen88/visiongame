import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:visiongame/enums/game_component_enums.dart';
import '../base/logger_utils.dart';
import '../injector/injection.dart';

///Below class is used for playing game sounds
class GameAudioPlayer{
  final _logger = locator<LoggerUtils>();
  final _TAG = "AudioPlayer";


  static final GameAudioPlayer _instance = GameAudioPlayer._init();

  static GameAudioPlayer get instance => _instance;

  GameAudioPlayer._init();


  Future<void> playGameSound(GameComponentEnums gameComponentEnums) async{
    _logger.log(_TAG, "Play coin collect sound");
    String audioasset = "";
    if(gameComponentEnums == GameComponentEnums.COINS){
      audioasset = 'assets/audio/collectcoin.mp3';
    }
    else if(gameComponentEnums == GameComponentEnums.HEARTS){
      audioasset = 'assets/audio/collectheart.mp3';
    }
    else if(gameComponentEnums == GameComponentEnums.DRAGON){
      audioasset = 'assets/audio/dragon_breathing.mp3';
    }
    if(audioasset.isNotEmpty){
      final Audio audio = Audio(audioasset);
      AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
      await assetsAudioPlayer.open(audio);
      await assetsAudioPlayer.play();
    }

  }

}
