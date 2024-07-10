import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:visiongame/base/constants.dart';
import 'package:visiongame/base/permission_utils.dart';
import 'package:visiongame/base/speech_input_model.dart';
import 'package:visiongame/enums/speech_input_enums.dart';
import 'package:visiongame/injector/injection.dart';

import '../../base/language_manager.dart';
import '../../base/logger_utils.dart';
import '../../generated/locale_keys.g.dart';
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

  BehaviorSubject<String?> startNextScreenEvent = BehaviorSubject<String?>.seeded(null);

  bool isSpeechInputEnabled = false;

  ///This flag is used to check if the language selection text is already spoken in home screen
  bool isLanguageSelectionSpoken = false;

  HomeScreenStateNotifer() : super(const HomeScreenViewState.loading()){
    listenToSpeechInput();
  }

  ///Step 1 - Display the loading animation for displaying hi robot on home screen
  void init() async{
    if(isSpeechInputEnabled){
      state = const HomeScreenViewState.loading();
      PermissionUtils permissionUtils = PermissionUtils();
      bool isPermissionGranted = await permissionUtils.askMicroPhonePermission();
      bool isSpeechInputInitialized = await visionSpeechInput.setUpVoiceInput();
      if(isPermissionGranted && isSpeechInputInitialized){
        state = const HomeScreenViewState.homeView();
        //startIntroduction();
        /*Future.delayed(Duration(seconds: 2),(){
        startIntroduction();

      });*/
      }
      else{
        state = const HomeScreenViewState.permissionDeniedView();
      }
    }
    else{
      state = const HomeScreenViewState.homeView();
      //chooseLanguage();
    }
  }

  void setLanguageView(){
    state = const HomeScreenViewState.chooseLanguageView();
  }

  Future<void> setAppLanguage(Locale locale) async{
    await startIntroduction();
  }

  Future<void> startIntroduction() async{

    //visionTts.enableSpeaking();
    String lineOne = LocaleKeys.home_intro_line_one.tr(namedArgs: {
      'appName' : ApplicationConstants.APP_NAME
    });
    await visionTts.speakText(lineOne);
    String lineTwo = LocaleKeys.home_intro_line_two.tr();
    await visionTts.speakText(lineTwo);
    String lineThree = LocaleKeys.home_intro_line_three.tr();
    await visionTts.speakText(lineThree);
    reloadBottomSheet(true);
  }


  ///When this function is loaded with value as true then bottom sheet is displayed on home screen
  ///for 5 seconds and then closed
  ///For this duration the speech input is also invoked for capturing what user is saying
  void reloadBottomSheet(bool value) async{
    await visionTts.speakStop();
    if(value){
      //bottomSheetEvent.add(true);
      if(isSpeechInputEnabled){
        bool isListening = await visionSpeechInput.startListening(SpeechInputEnums.START_GAME);
        if(isListening){
          Future.delayed(Duration(seconds: ApplicationConstants.kSpeechTimerLimit),() async{
            _logger.log(_TAG, "Stop bottom sheet now");
            if(visionSpeechInput.isSpeechEnabled){
              bool isStopped = await visionSpeechInput.stopListening();
              if(isStopped){
                //bottomSheetEvent.add(false);
              }
            }
          });
        }
      }
      else{
        Future.delayed(Duration(seconds: ApplicationConstants.kSpeechTimerLimit),() async{
          _logger.log(_TAG, "Stop bottom sheet now");
          //bottomSheetEvent.add(false);
        });
      }
    }
    else{
      //bottomSheetEvent.add(false);
      if(isSpeechInputEnabled){
        if(visionSpeechInput.isSpeechEnabled){
          await visionSpeechInput.stopListening();
        }
      }

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
    //bottomSheetEvent.add(false);
    startNextScreenEvent.add(value);
  }

  void test() async{
    /*String text1 = "Hey I wish I could have done this project";
    String text2 = "This game is an amazing project to work upon";
    String text3 = "What I am testing is the vision TTS";
    visionTts.speakText(text1);
    visionTts.speakText(text2);
    visionTts.speakText(text3);*/
    visionTts.getSupportedLanguagesAndVoices();
  }

  Future<bool> stopSpeaking() async{
    return await visionTts.speakStop();
  }
}