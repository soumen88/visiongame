import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:visiongame/difficultylevel/difficulty_level.dart';

import '../base/constants.dart';
import '../router/app_router.gr.dart';

class SplashScreenPage extends HookWidget {

  String TAG = "SplashScreen";

  @override
  Widget build(BuildContext context) {
    //Start home screen whenever timer is over
    useEffect((){
      Future.delayed(Duration(seconds: ApplicationConstants.kSplashScreenTime), () {
        //context.router.replace(const HomeScreenRoute());
        context.router.replace(const MainGameRoute());
      });
    });

    // Display Splash screen logo
    return Scaffold(
      backgroundColor: ApplicationConstants.splashBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: const DecorationImage(
                            image: AssetImage(
                              "assets/images/logo.png",
                            )
                        )
                    ),
                  ),
                ),
              ),
              const Text(ApplicationConstants.APP_NAME,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

}