import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:visiongame/base/speech_input_model.dart';
import 'package:visiongame/enums/speech_input_enums.dart';
import 'package:visiongame/injector/injection.dart';

import '../base/logger_utils.dart';

@injectable
class VisionSpeechInput{
  final _TAG = "VisionSpeechInput";
  final _logger = locator<LoggerUtils>();
  SpeechToText _speechToText = SpeechToText();
  bool _isSpeechEnabled = false;
  SpeechInputEnums? currentEnum;
  String _lastWords = "";
  final BehaviorSubject<SpeechInputModel?> currentInput = BehaviorSubject.seeded(null);


  Future<void> setUpVoiceInput() async{
    _isSpeechEnabled = await _speechToText.initialize();
  }

  /// Each time to start a speech recognition session
  Future<void> startListening(SpeechInputEnums currentInput) async {
    if(!_isSpeechEnabled){
      await setUpVoiceInput();
    }
    _logger.log(_TAG, "Is speech enabled $_isSpeechEnabled");
    if(currentInput == SpeechInputEnums.START_GAME){
      currentEnum = SpeechInputEnums.START_GAME;
      await _speechToText.listen(onResult: onSpeechResult);
    }
    if(currentInput == SpeechInputEnums.RESTART_GAME){
      currentEnum = SpeechInputEnums.RESTART_GAME;
      await _speechToText.listen(onResult: onSpeechResult);
    }

  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;
    _logger.log(_TAG, "Start listening $_lastWords");

  }

  ///Stop listening for speech input
  Future<void> stopListening() async{
    await _speechToText.stop();
    _logger.log(_TAG, "Adding data to speech input model");
    SpeechInputModel speechInputModel = SpeechInputModel(textRecognized: _lastWords, speechInputEnums: currentEnum!);
    currentInput.add(speechInputModel);
  }
}