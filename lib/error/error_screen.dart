import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:visiongame/base/constants.dart';

import '../providers/provider.dart';

class ErrorScreen extends HookConsumerWidget {

  String errorMessage;

  ErrorScreen({required this.errorMessage});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final homeNotifier = ref.watch(homeScreenProviders.notifier);


    useEffect((){
      Future.delayed(Duration(seconds: 1),(){
        //displayError();
      });
    }, const []);


    return Scaffold(
      backgroundColor: Colors.lightGreen,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Lottie.asset('assets/animation/permission_denied.json'),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.14,
            left: MediaQuery.of(context).size.width * 0.065,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    blurRadius: 25,
                    color: Colors.black.withOpacity(0.17),
                  ),
                ],
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)), backgroundColor: Colors.white
                ),
                onPressed: () async{

                  await openAppSettings();

                },
                child: const Text("Open Settings", style: TextStyle(
                    color: Colors.black,
                  fontSize: 22
                ),),
              ),
            ),
          )
        ],
      ),
    );
  }
}