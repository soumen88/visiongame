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

  Future<bool> speakText(String inputText) async{
    await _textToSpeechConverter.speak(inputText);
    return Future.value(true);
  }

}