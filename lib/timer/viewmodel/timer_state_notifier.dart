import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visiongame/base/constants.dart';
import 'package:visiongame/injector/injection.dart';
import 'package:visiongame/timer/model/timer_view_state.dart';

import '../../base/logger_utils.dart';

class TimerStateNotifier extends StateNotifier<TimerViewState> {

  final _TAG = "TimerStateNotifier";
  final _logger = locator<LoggerUtils>();

  ///Below variable is displayed on timer container
  int secondsPassed = 0;

  TimerStateNotifier() : super(const TimerViewState.displayTime(false, 0));


  void startTimer(){
    final Stream<int> _timerStream =
    Stream.periodic(const Duration(seconds: 1), (int count) {
      return count;
    }).takeWhile((element) => secondsPassed < ApplicationConstants.kTimerLimit);

    _timerStream.listen((int event) {
        _logger.log(_TAG, "Event $event");
        secondsPassed = event;
        state = TimerViewState.displayTime(true, secondsPassed);
        if(secondsPassed == ApplicationConstants.kTimerLimit){
          state = TimerViewState.displayTime(false, secondsPassed);
        }
    });



  }
}