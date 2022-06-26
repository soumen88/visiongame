import 'package:visiongame/enums/speech_input_enums.dart';

class SpeechInputModel{
  String textRecognized;
  SpeechInputEnums speechInputEnums;

  SpeechInputModel({required this.textRecognized, required this.speechInputEnums});

  @override
  String toString() {
    return 'SpeechInputModel{textRecognized: $textRecognized, speechInputEnums: $speechInputEnums}';
  }
}