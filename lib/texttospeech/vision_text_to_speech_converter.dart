import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:visiongame/injector/injection.dart';

import '../base/logger_utils.dart';

@injectable
class VisionTextToSpeechConverter{
  final _TAG = "VisionTextToSpeechConverter";
  final _logger = locator<LoggerUtils>();
  final FlutterTts _textToSpeechConverter = FlutterTts();
  static final VisionTextToSpeechConverter instance = VisionTextToSpeechConverter.init();

  VisionTextToSpeechConverter.init(){
    _logger.log(_TAG, "Setting up text to speech converter");
    setUpTTs();
  }

  void setUpTTs(){
    _textToSpeechConverter.setLanguage('en');
    _textToSpeechConverter.setSpeechRate(0.4);
  }

  void speakText(String inputText) async{
    await _textToSpeechConverter.speak(inputText);
  }

}