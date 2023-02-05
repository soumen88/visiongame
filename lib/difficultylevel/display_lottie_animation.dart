import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DisplayLottieAnimation extends StatelessWidget{
  String lottieFilePath;
  String label;

  DisplayLottieAnimation({required this.lottieFilePath,required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          Lottie.asset(
              lottieFilePath,
              width: 100,
              height: 100
          )
        ],
      ),
    );
  }

}