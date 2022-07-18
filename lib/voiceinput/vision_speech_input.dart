import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:visiongame/base/speech_input_model.dart';
import 'package:visiongame/enums/speech_input_enums.dart';
import 'package:visiongame/injector/injection.dart';

import '../base/logger_utils.dart';

class VisionSpeechInput{
  static final VisionSpeechInput _instance = VisionSpeechInput._init();

  static VisionSpeechInput get instance => _instance;

  VisionSpeechInput._init();

  final _TAG = "VisionSpeechInput";
  final _logger = locator<LoggerUtils>();
  SpeechToText _speechToText = SpeechToText();
  bool isSpeechEnabled = false;
  SpeechInputEnums? currentEnum;
  String _lastWords = "";
  final BehaviorSubject<SpeechInputModel?> currentInput = BehaviorSubject.seeded(null);

  Future<bool> setUpVoiceInput() async{
    if(isSpeechEnabled == false){

      isSpeechEnabled = await _speechToText.initialize( onStatus: speechInputStatusListener, onError: speechInputErrorListener );
    }
    _logger.log(_TAG, "is speech enabled ${isSpeechEnabled}");
    return Future.value(isSpeechEnabled);
  }

  /// Each time to start a speech recognition session
  Future<bool> startListening(SpeechInputEnums currentInput) async {
    /*if(!_isSpeechEnabled){
      await setUpVoiceInput();
    }*/

    if(currentInput == SpeechInputEnums.START_GAME){
      _logger.log(_TAG, "Listening for starting game");
      currentEnum = SpeechInputEnums.START_GAME;
      await _speechToText.listen(onResult: onSpeechResult);
    }
    if(currentInput == SpeechInputEnums.RESTART_GAME){
      currentEnum = SpeechInputEnums.RESTART_GAME;
      await _speechToText.listen(onResult: onSpeechResult);
    }
    if(currentInput == SpeechInputEnums.DIFFICULTY_LEVEL){
      currentEnum = SpeechInputEnums.DIFFICULTY_LEVEL;
      await _speechToText.listen(onResult: onSpeechResult);
      _logger.log(_TAG, "Listening for difficulty level in game ${_speechToText.isListening} for enum $currentEnum");
    }

    return Future.value(isSpeechEnabled);
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
    _logger.log(_TAG, "Start listening $_lastWords");
  }

  ///Stop listening for speech input
  Future<bool> stopListening() async{
    if(currentEnum != null){
      await _speechToText.stop();
      isSpeechEnabled = false;
      _logger.log(_TAG, "Adding data to speech input model");
      SpeechInputModel speechInputModel = SpeechInputModel(textRecognized: _lastWords, speechInputEnums: currentEnum!);
      currentInput.add(speechInputModel);
      currentEnum = null;
      return Future.value(true);
    }
    return Future.value(false);
  }

  ///In android the speech input is set by device and cannot be changed
  ///Hence whenever the value changes to not listening then we are again forcing the speech to text to
  ///listen to users words
  void speechInputStatusListener(String value) async{
    //_logger.log(_TAG, "Status changed to value $value and enum ${currentEnum} and speech enabled ${isSpeechEnabled}");
    if(value == "notListening" && isSpeechEnabled){
      await _speechToText.listen(onResult: onSpeechResult);
    }
  }

  void speechInputErrorListener(SpeechRecognitionError value){
    //_logger.log(_TAG, "Error Listening to value $value");
  }

  void checkIfListening(){
    _logger.log(_TAG, "Check if listening ${_speechToText.isListening}");
  }
}