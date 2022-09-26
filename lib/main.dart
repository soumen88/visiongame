import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:injectable/injectable.dart';
import 'package:visiongame/router/app_router.gr.dart';
import 'package:visiongame/texttospeech/vision_text_to_speech_converter.dart';
import 'base/constants.dart';
import 'injector/injection.dart';

void main() async{
  await _init();
  runApp(ProviderScope(child: MyApp()));
}

Future<void> _init() async{
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  final visiontts = locator<VisionTextToSpeechConverter>();
  await visiontts.setUpTTs();
}

@injectable
class MyApp extends HookConsumerWidget {
  ///Creating app router object which shall be used throughout the app
  final _appRouter = locator<AppRouter>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp.router(
      debugShowCheckedModeBanner: true,
      title: ApplicationConstants.APP_NAME,
      routeInformationParser: _appRouter.defaultRouteParser(),
      routerDelegate: _appRouter.delegate(),
      theme: ThemeData(
          primarySwatch: Colors.deepOrange
      ),
      builder: (context, router) => router!,
    );
  }

}