import 'package:injectable/injectable.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:visiongame/injector/injection.dart';

import '../base/logger_utils.dart';

@injectable
class VisionSpeechInput{
  final _TAG = "VisionSpeechInput";
  final _logger = locator<LoggerUtils>();
  SpeechToText _speechToText = SpeechToText();
  bool _isSpeechEnabled = false;


  Future<void> setUpVoiceInput() async{
    _isSpeechEnabled = await _speechToText.initialize();
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    if(!_isSpeechEnabled){
      await setUpVoiceInput();
    }
    _logger.log(_TAG, "Is speech enabled $_isSpeechEnabled");
    await _speechToText.listen(onResult: onSpeechResult);
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    String _lastWords = result.recognizedWords;
    _logger.log(_TAG, "Start listening $_lastWords");

  }
}