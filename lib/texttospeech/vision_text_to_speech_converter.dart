import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:visiongame/injector/injection.dart';

import '../base/logger_utils.dart';

@injectable
class VisionTextToSpeechConverter{
  final _TAG = "VisionTextToSpeechConverter";
  final _logger = locator<LoggerUtils>();
  final FlutterTts _textToSpeechConverter = FlutterTts();

  Future<void> setUpTTs() async{
    await _textToSpeechConverter.setVolume(1.0);
    await _textToSpeechConverter.awaitSpeakCompletion(true);
    await _textToSpeechConverter.setLanguage('en');
    await _textToSpeechConverter.setSpeechRate(0.4);
  }

  ///When the result from speak is 1 then it indicates that current speak part is complete
  ///Hence we are sending true only once the sentence is finished
  Future<bool> speakText(String inputText) async{
    var result = await _textToSpeechConverter.speak(inputText);
    if(result == 1){
      return Future.value(true);
    }
    else{
      return Future.value(false);
    }
  }

  ///When the result from speak is 1 then it indicates that current speak part is complete
  ///Hence we are sending true only once the sentence is finished
  Future<bool> speakStop() async{
    var result = await _textToSpeechConverter.stop();
    if(result == 1){
      return Future.value(true);
    }
    else{
      return Future.value(false);
    }
  }

}