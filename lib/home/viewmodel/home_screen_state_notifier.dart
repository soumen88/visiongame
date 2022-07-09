import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/base/constants.dart';
import 'package:visiongame/base/permission_utils.dart';
import 'package:visiongame/base/speech_input_model.dart';
import 'package:visiongame/enums/speech_input_enums.dart';
import 'package:visiongame/injector/injection.dart';

import '../../base/logger_utils.dart';
import '../../texttospeech/vision_text_to_speech_converter.dart';
import '../../voiceinput/vision_speech_input.dart';
import '../model/home_screen_view_state.dart';

class HomeScreenStateNotifer extends StateNotifier<HomeScreenViewState> {
  final _logger = locator<LoggerUtils>();
  final _TAG = "HomeScreenStateNotifer";
  ///Below variable is used for text to speech
  final visionTts = locator<VisionTextToSpeechConverter>();
  ///Below variable is used for taking speech input from user
  final visionSpeechInput = locator<VisionSpeechInput>();

  ///Below variable is used for displaying bottom sheet on the home screen
  BehaviorSubject<bool?> bottomSheetEvent = BehaviorSubject<bool?>.seeded(null);
  BehaviorSubject<String?> startNextScreenEvent = BehaviorSubject<String?>.seeded(null);

  HomeScreenStateNotifer() : super(const HomeScreenViewState.loading()){
    listenToSpeechInput();
  }

  ///Step 1 - Display the loading animation for displaying hi robot on home screen
  void init() async{
    state = const HomeScreenViewState.loading();
    PermissionUtils permissionUtils = PermissionUtils();
    bool isPermissionGranted = await permissionUtils.askMicroPhonePermission();
    bool isSpeechInputInitialized = await visionSpeechInput.setUpVoiceInput();
    if(isPermissionGranted && isSpeechInputInitialized){
      state = const HomeScreenViewState.homeView();
      Future.delayed(Duration(seconds: 2),(){
        //startIntroduction();
        reloadBottomSheet(true);
      });
    }
  }

  void startIntroduction() async{
    String lineOne = "Hello I am Amaze Robot.";
    await visionTts.speakText(lineOne);
    String lineTwo = "I would be assisting you to play this Amazing game.";
    await visionTts.speakText(lineTwo);
    String lineThree = "To Continue playing, Please speak ready or double tap any where on the screen";
    await visionTts.speakText(lineThree);
    reloadBottomSheet(true);
  }


  ///When this function is loaded with value as true then bottom sheet is displayed on home screen
  ///for 5 seconds and then closed
  ///For this duration the speech input is also invoked for capturing what user is saying
  void reloadBottomSheet(bool value) async{
    bottomSheetEvent.add(true);
    bool isListening = await visionSpeechInput.startListening(SpeechInputEnums.START_GAME);
    if(isListening){
      Future.delayed(Duration(seconds: ApplicationConstants.kSpeechTimerLimit),() async{
        _logger.log(_TAG, "Stop bottom sheet now");
        await visionSpeechInput.stopListening();
        bottomSheetEvent.add(false);
      });
    }

  }

  ///Whatever the user has spoken will be listened here
  void listenToSpeechInput(){
    visionSpeechInput.currentInput.listen((SpeechInputModel? inputModel) {
      _logger.log(_TAG, "Input model $inputModel");
      if(inputModel != null && inputModel.textRecognized.isNotEmpty &&
          inputModel.speechInputEnums == SpeechInputEnums.START_GAME){
        if(inputModel.textRecognized.contains("start") || inputModel.textRecognized.contains("ready")){
            startNextScreen(ApplicationConstants.ScreenDifficulty);
        }
      }

    });
  }

  void startNextScreen(String value){
    startNextScreenEvent.add(value);
  }
}