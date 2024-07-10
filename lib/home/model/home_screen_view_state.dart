import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_screen_view_state.freezed.dart';

///Below Class is all the states that are applicable to home screen view
@freezed
class HomeScreenViewState with _$HomeScreenViewState {
  const factory HomeScreenViewState.error(String errorMessage) = _Error;
  const factory HomeScreenViewState.loading() = _Loading;
  const factory HomeScreenViewState.homeView() = _HomeView;
  const factory HomeScreenViewState.chooseLanguageView() = _ChooseLanguageView;
  const factory HomeScreenViewState.permissionDeniedView() = _PermissionDeniedView;
}