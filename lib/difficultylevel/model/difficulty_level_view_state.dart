import 'package:freezed_annotation/freezed_annotation.dart';

part 'difficulty_level_view_state.freezed.dart';

///Below Class is all the states that are applicable to home screen view
@freezed
class DifficultyLevelViewState with _$DifficultyLevelViewState {
  const factory DifficultyLevelViewState.error(String errorMessage) = _Error;
  const factory DifficultyLevelViewState.loading() = _Loading;
  const factory DifficultyLevelViewState.homeView() = _LevelView;
  const factory DifficultyLevelViewState.startGameView() = _StartGameView;
}