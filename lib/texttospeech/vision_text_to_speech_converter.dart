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
  bool isStop = false;

  Future<void> setUpTTs() async{
    await _textToSpeechConverter.setLanguage("en-US");
    await _textToSpeechConverter.setSpeechRate(0.5);
    await _textToSpeechConverter.setVolume(1.0);
    await _textToSpeechConverter.setPitch(1.0);
    await _textToSpeechConverter.awaitSpeakCompletion(true);

    bool isLanguageAvailable = await _textToSpeechConverter.isLanguageAvailable("hi-IN");
    _logger.log(_TAG, "Is language available hindi $isLanguageAvailable");
    var listOfdata = await _textToSpeechConverter.getVoices;
    _logger.log(_TAG, "Voices $listOfdata");
    if(isLanguageAvailable){
      await _textToSpeechConverter.setLanguage('hi-IN');
      //await _textToSpeechConverter.setVoice({"name": "hi-in-x-hid-local", "locale": "hi-IN"});
      await _textToSpeechConverter.setVoice({"name": "hi-IN-default", "locale": "hin-default"});
    }
  }

  ///When the result from speak is 1 then it indicates that current speak part is complete
  ///Hence we are sending true only once the sentence is finished
  Future<bool> speakText(String inputText) async{
    _logger.log(_TAG, "Inside speak text $inputText and $isStop");
    if(isStop == false){
      var result = await _textToSpeechConverter.speak(inputText);
      if(result == 1){
        return Future.value(true);
      }
      else{
        return Future.value(false);
      }
    }
    else{
      return Future.value(false);
    }
  }

  void enableSpeaking(){
    isStop = false;
  }

  ///When the result from speak is 1 then it indicates that current speak part is complete
  ///Hence we are sending true only once the sentence is finished
  Future<bool> speakStop() async{
    isStop = true;
    var result = await _textToSpeechConverter.stop();
    if(result == 1){
      return Future.value(true);
    }
    else{
      return Future.value(false);
    }
  }

  Future<void> getSupportedLanguagesAndVoices() async{
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