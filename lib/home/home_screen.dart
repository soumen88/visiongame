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
  final visionTts = locator<VisionTextToSpeechConverter>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeScreenNotifier = ref.watch(homeScreenProviders.notifier);
    final languageChangeNotifier = ref.watch(languageProvider.notifier);
    final timerNotifier = ref.watch(timerProvider.notifier);
    final homeScreenState = ref.watch(homeScreenProviders);
    final startNextScreen = useStream(homeScreenNotifier.startNextScreenEvent.stream);

    final appLifecycleState = useAppLifecycleState();

    Future<void> chooseEnglish({bool dontSpeak = false}) async{
      LanguageListItemModel english = LanguageManager.instance.getEnglishLang();
      languageChangeNotifier.saveLocale(english);
      await context.setLocale(english.locale);
      await visionTts.setUpTTs(setupLanguage: LanguageManager.instance.enLocale);
      if(dontSpeak){
        return;
      }
      String lineTwo = LocaleKeys.home_choose_lang_line_one.tr();
      await visionTts.speakText(lineTwo);
    }

    Future<void> chooseHindi({bool dontSpeak = false}) async{

      LanguageListItemModel hindi = LanguageManager.instance.getHindiLang();
      languageChangeNotifier.saveLocale(hindi);
      await context.setLocale(hindi.locale);
      await visionTts.setUpTTs(setupLanguage: LanguageManager.instance.hiLocale);
      if(dontSpeak){
        return;
      }
      String lineOne = LocaleKeys.home_choose_lang_line_one.tr();
      await visionTts.speakText(lineOne);
    }

    Future<void> chooseLanguage() async{
      await chooseHindi();
      await chooseEnglish();
      homeScreenNotifier.setLanguageView();
    }

    useEffect(() {
      _logger.log(_TAG, "current app state ${appLifecycleState }");

      if (appLifecycleState == AppLifecycleState.paused || appLifecycleState == AppLifecycleState.inactive) {
        homeScreenNotifier.stopSpeaking();
      } else if (appLifecycleState == AppLifecycleState.resumed) {
        Future.delayed(Duration.zero, (){
          homeScreenNotifier.init();
          if(!homeScreenNotifier.isLanguageSelectionSpoken){
            homeScreenNotifier.isLanguageSelectionSpoken = true;
            chooseLanguage();
          }


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
              bool hasStoppedSpeaking = await homeScreenNotifier.stopSpeaking();
              if(hasStoppedSpeaking){
                homeScreenNotifier.startNextScreen(ApplicationConstants.ScreenDifficulty);
              }
            },
            child: Scaffold(
              backgroundColor: Colors.lightGreen,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

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
          return Scaffold(
            backgroundColor: Colors.lightGreen,
            body: Center(
              child: SwipeDetector(
                behavior: HitTestBehavior.opaque,
                //Start tutorial
                onSwipeUp: (Offset offset) async{
                  ///When Hindi language is selected then its a swipe up
                  _logger.log(_TAG, "Swipe Up done");
                  await chooseHindi(dontSpeak: true);
                  await homeScreenNotifier.setAppLanguage(LanguageManager.instance.hiLocale);
                },
                //Begin a fresh game
                onSwipeDown: (Offset offset) async{
                  ///When English language is selected then its a swipe down
                  _logger.log(_TAG, "Swipe down done");
                  await chooseEnglish(dontSpeak: true);
                  await homeScreenNotifier.setAppLanguage(LanguageManager.instance.enLocale);
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text(
                            "Continue in Hindi",
                            style: TextStyle(
                                fontSize: 30
                            ),
                          ),
                          Lottie.asset(
                              'assets/animation/swipe_up.json',
                              height: 200
                          ),
                        ],
                      )
                    ),
                    Expanded(
                        flex: 1,
                        child: RobotWaveWidget(),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Lottie.asset(
                                'assets/animation/swipe_down.json',
                                height: 200
                            ),
                            Text(
                                "Continue in English",
                                style: TextStyle(
                                  fontSize: 30
                                ),
                            ),
                          ],
                        ),
                    )
                  ],
                )

              ),
            ),
          );
        },
        orElse: (){
          return LoadingWidget();
        }
    );
  }

}