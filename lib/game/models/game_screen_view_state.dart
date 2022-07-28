import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_screen_view_state.freezed.dart';

///Below Class is all the states that are applicable to home screen view
@freezed
class GameScreenViewState with _$GameScreenViewState {
  const factory GameScreenViewState.error(String errorMessage) = _Error;
  const factory GameScreenViewState.loading() = _Loading;
  const factory GameScreenViewState.displayGameView() = _DisplayGameView;
  const factory GameScreenViewState.displayGameOver() = _DisplayGameOver;
  const factory GameScreenViewState.displayGameWin() = _DisplayGameWin;
  const factory GameScreenViewState.displayTutorialView() = _DisplayTutorialView;
  const factory GameScreenViewState.displayRobotView() = _DisplayRobotView;
}