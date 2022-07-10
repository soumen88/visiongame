import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visiongame/base/empty_widget.dart';
import 'package:visiongame/injector/injection.dart';
import 'package:visiongame/providers/provider.dart';

import '../base/logger_utils.dart';


class TimerContainer extends HookConsumerWidget{
  String timerLabel;
  String durationLabel;
  final _logger = locator<LoggerUtils>();
  final _TAG = "TimerContainer";
  TimerContainer({required this.timerLabel, required this.durationLabel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerNotifier = ref.watch(timerProvider.notifier);
    final timerStateProvider = ref.watch(timerProvider);

    return timerStateProvider.maybeWhen(
        displayTime: (bool isTimerVisible, int seconds){
          //_logger.log(_TAG, "Is timer visible $isTimerVisible and seconds $seconds ");
          if(isTimerVisible){
            return Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black
              ),
              child: Column(
                children: [
                  Text(
                    "${timerNotifier.secondsPassed}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text("$timerLabel",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            );
          }
          else{
            return EmptyWidget();
          }
        },
        orElse: (){
          return EmptyWidget();
        }
    );
  }

}