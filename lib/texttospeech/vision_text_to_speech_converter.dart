import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/appmodels/language_list_item_model.dart';
import 'package:visiongame/base/language_manager.dart';
import 'package:visiongame/injector/injection.dart';

import '../base/logger_utils.dart';

@injectable
class VisionTextToSpeechConverter{
  final _TAG = "VisionTextToSpeechConverter";
  final _logger = locator<LoggerUtils>();
  FlutterTts _textToSpeechConverter = FlutterTts();
  BehaviorSubject<bool?> speechEventNotifier = BehaviorSubject.seeded(null);
  bool isStop = false;

  Future<void> setUpTTs({Locale? setupLanguage}) async{
    var listOfdata = await _textToSpeechConverter.getVoices;
    _logger.log(_TAG, "Voices $listOfdata");
    await _textToSpeechConverter.setSpeechRate(0.4);
    await _textToSpeechConverter.setVolume(1.0);
    await _textToSpeechConverter.setPitch(1.0);
    await _textToSpeechConverter.awaitSpeakCompletion(true);
    if(setupLanguage != null){
      if(setupLanguage == LanguageManager.instance.enLocale){
        await _textToSpeechConverter.setLanguage("en-US");
      }
      else{
        await setupHindiLanguage();
      }
    }
    else{
      await setupHindiLanguage();
      //await _textToSpeechConverter.setLanguage("en-US");
    }
  }

  Future<void> setupHindiLanguage() async{
    bool isLanguageAvailable = await _textToSpeechConverter.isLanguageAvailable("hi-IN");
    _logger.log(_TAG, "Is language available hindi $isLanguageAvailable");
    if(isLanguageAvailable){
      await _textToSpeechConverter.setLanguage('hi-IN');
      await _textToSpeechConverter.setVoice({"name": "hi-IN-default", "locale": "hin-default"});
      //await _textToSpeechConverter.setVoice({"name": "hi-IN-SMTf00", "locale": "hin-x-lvariant-f00"});
      //await _textToSpeechConverter.setVoice({"name": "es-MX-default", "locale": "spa-default"});
    }
    else{
      await _textToSpeechConverter.setLanguage("en-US");
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