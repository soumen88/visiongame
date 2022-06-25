import 'package:freezed_annotation/freezed_annotation.dart';

part 'timer_view_state.freezed.dart';

///Below Class is all the states that are applicable to timer screen
@freezed
class TimerViewState with _$TimerViewState {
  const factory TimerViewState.error(String errorMessage) = _Error;
  const factory TimerViewState.loading() = _Loading;
  const factory TimerViewState.displayTime(bool isTimerVisible, int seconds) = _DisplayTime;
}