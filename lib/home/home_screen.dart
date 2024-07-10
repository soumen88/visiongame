import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:visiongame/appmodels/language_list_item_model.dart';
import 'package:visiongame/enums/speech_input_enums.dart';
import 'package:visiongame/error/error_screen.dart';
import 'package:visiongame/home/start_listening_widget.dart';
import 'package:visiongame/home/viewmodel/robot_wave_widget.dart';
import 'package:visiongame/injector/injection.dart';
import 'package:visiongame/router/app_router.dart';
import 'package:visiongame/timer/timer_container.dart';

import '../audioplayer/game_audio_player.dart';
import '../base/constants.dart';
import '../base/language_manager.dart';
import '../base/logger_utils.dart';
import '../game/helpers/swipe_detector.dart';
import '../generated/locale_keys.g.dart';
import '../loading/loading_widget.dart';
import '../providers/provider.dart';
import '../texttospeech/vision_text_to_speech_converter.dart';
import '../voiceinput/vision_speech_input.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget{

  final _logger = locator<LoggerUtils>();
  final _TAG = "HomeScreenPage";
  bool isBottomSheetDisplayed = false;
  bool? isEnabled;
  final visionTts = locator<VisionTextToSpeechConverter>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeScreenNotifier = ref.watch(homeScreenProviders.notifier);
    final languageChangeNotifier = ref.watch(languageProvider.notifier);
    final timerNotifier = ref.watch(timerProvider.notifier);
    final homeScreenState = ref.watch(homeScreenProviders);
    final startNextScreen = useStream(homeScreenNotifier.startNextScreenEvent.stream);

    final appLifecycleState = useAppLifecycleState();

    Future<void> chooseLanguage() async{
      String lineOne = LocaleKeys.home_choose_lang_line_one.tr();
      LanguageListItemModel hindi = LanguageManager.instance.getHindiLang();
      languageChangeNotifier.saveLocale(hindi);
      await context.setLocale(hindi.locale);
      await visionTts.setUpTTs(setupLanguage: LanguageManager.instance.hiLocale);
      await visionTts.speakText(lineOne);

      LanguageListItemModel english = LanguageManager.instance.getEnglishLang();
      languageChangeNotifier.saveLocale(english);
      await context.setLocale(english.locale);
      String lineTwo = LocaleKeys.home_choose_lang_line_one.tr();
      await visionTts.setUpTTs(setupLanguage: LanguageManager.instance.enLocale);
      await visionTts.speakText(lineTwo);
    }

    useEffect(() {
      _logger.log(_TAG, "current app state ${appLifecycleState }");

      if (appLifecycleState == AppLifecycleState.paused || appLifecycleState == AppLifecycleState.inactive) {
        homeScreenNotifier.stopSpeaking();
      } else if (appLifecycleState == AppLifecycleState.resumed) {
        Future.delayed(Duration.zero, (){
          homeScreenNotifier.init();
          chooseLanguage();
          isEnabled = true;
        });

      }
      return null;
    }, [appLifecycleState]);



    void displayBottomSheet(){
      showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(30.0), topRight: Radius.circular(30.0)),
        ),
        context: context,
        barrierColor: Colors.white.withOpacity(0.0),
        builder: (context) {
          return StartListeningWidget();
        },
      );
    }


    if(startNextScreen.data != null && startNextScreen.data == ApplicationConstants.ScreenDifficulty){
      _logger.log(_TAG, "Start next screen now");
      //context.router.navigate(const DifficultyLevelScreen());
      context.router.replace(const DifficultyLevelRoute());
    }


    return homeScreenState.maybeWhen(
        homeView: (){
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async{
              if(isEnabled != null && isEnabled!){
                isEnabled = false;
                bool hasStoppedSpeaking = await homeScreenNotifier.stopSpeaking();
                if(hasStoppedSpeaking){
                  homeScreenNotifier.startNextScreen(ApplicationConstants.ScreenDifficulty);
                }
              }
            },
            child: Scaffold(
              backgroundColor: Colors.lightGreen,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /*Container(
                    margin: EdgeInsets.all(50),
                    child: ElevatedButton(onPressed: () async{
                      if(isEnabled != null && isEnabled!){
                        isEnabled = false;
                        bool hasStoppedSpeaking = await homeScreenNotifier.stopSpeaking();
                        if(hasStoppedSpeaking){
                          homeScreenNotifier.startNextScreen(ApplicationConstants.ScreenDifficulty);
                        }
                      }

                    }, child: Text("Test")),
                  ),*/
                  RobotWaveWidget()
                ],
              )
            ),
          );
        },
        permissionDeniedView: (){
          return ErrorScreen(errorMessage: ApplicationConstants.PermissionDeniedMessage);
        },
        chooseLanguageView: (){
          return SwipeDetector(
            behavior: HitTestBehavior.opaque,
            //Start tutorial
            onSwipeUp: (Offset offset) async{
              _logger.log(_TAG, "Swipe Up done");

            },
            //Begin a fresh game
            onSwipeDown: (Offset offset) async{
              _logger.log(_TAG, "Swipe down done");
            },
            child: RobotWaveWidget(),
          );
        },
        orElse: (){
          return LoadingWidget();
        }
    );
  }

}