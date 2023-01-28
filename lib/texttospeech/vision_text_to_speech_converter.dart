import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/injector/injection.dart';

import '../base/logger_utils.dart';

@injectable
class VisionTextToSpeechConverter{
  final _TAG = "VisionTextToSpeechConverter";
  final _logger = locator<LoggerUtils>();
  FlutterTts _textToSpeechConverter = FlutterTts();
  BehaviorSubject<bool?> speechEventNotifier = BehaviorSubject.seeded(null);
  bool isSpeaking = true;

  Future<void> setUpTTs() async{
    _textToSpeechConverter = FlutterTts();
    await _textToSpeechConverter.setVolume(1.0);
    await _textToSpeechConverter.awaitSpeakCompletion(true);

    await _textToSpeechConverter.setLanguage('hi-IN');
    //Good female
    //await _textToSpeechConverter.setVoice({"name": "hi-IN-language", "locale": "hi-IN"});
    //Good male
    await _textToSpeechConverter.setVoice({"name": "hi-in-x-hid-local", "locale": "hi-IN"});
    //await _textToSpeechConverter.setVoice({"name": "hi-in-x-hid-network", "locale": "hi-IN"});
    await _textToSpeechConverter.setSpeechRate(0.4);
    //await _textToSpeechConverter.setQueueMode(2);

  }

  ///When the result from speak is 1 then it indicates that current speak part is complete
  ///Hence we are sending true only once the sentence is finished
  Future<bool> speakText(String inputText) async{
    _logger.log(_TAG, "Inside speak text $inputText");
    var result = await _textToSpeechConverter.speak(inputText);
    if(result == 1){
      return Future.value(true);
    }
    else{
      return Future.value(false);
    }


    /*speechEventNotifier.add(inputText);
    return Future.value(true);*/
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

  Future<void> test() async{
    List<dynamic> languages = await _textToSpeechConverter.getLanguages;
    for(var language in languages){
      //_logger.log(_TAG, "Language $language");
    }
    List<dynamic> voices = await _textToSpeechConverter.getVoices;
    for(var voice in voices){
      _logger.log(_TAG, "Voice $voice");
    }
  }
}