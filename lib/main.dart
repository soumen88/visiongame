import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:visiongame/base/language_manager.dart';
import 'package:visiongame/base/logger_utils.dart';
import 'package:visiongame/providers/provider.dart';
import 'package:visiongame/router/app_router.dart';
import 'package:visiongame/texttospeech/vision_text_to_speech_converter.dart';
import 'base/constants.dart';
import 'injector/injection.dart';

void main() async{
  await _init();
}

Future<void> _init() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  configureDependencies();
  final visiontts = locator<VisionTextToSpeechConverter>();
  await visiontts.setUpTTs();
  runApp(
      ProviderScope(
        child: EasyLocalization(
            supportedLocales: [LanguageManager.instance.enLocale, LanguageManager.instance.hiLocale],
            path: 'assets/lang',
            fallbackLocale: Locale('en', 'US'),
            startLocale: LanguageManager.instance.hiLocale,
            child: MyApp()
        ),
      )
  );
}

@injectable
class MyApp extends HookConsumerWidget {
  ///Creating app router object which shall be used throughout the app
  final _appRouter = locator<AppRouter>();
  final _logger = locator<LoggerUtils>();
  final _TAG = "MyApp";
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageChangeNotifier = ref.read(languageProvider.notifier);
    context.setLocale(languageChangeNotifier.currentLocaleListItemModel.locale);
    _logger.log(_TAG, "Changing the locale to ${languageChangeNotifier.currentLocaleListItemModel.locale}");
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    useEffect((){
      final visiontts = locator<VisionTextToSpeechConverter>();
      visiontts.setUpTTs();
    }, []);
    return MaterialApp.router(
      debugShowCheckedModeBanner: true,
      title: ApplicationConstants.APP_NAME,
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
      theme: ThemeData(
          primarySwatch: Colors.deepOrange
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: (context, router) => router!,
    );
  }

}