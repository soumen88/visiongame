import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visiongame/base/constants.dart';

import '../model/home_screen_view_state.dart';

class HomeScreenStateNotifer extends StateNotifier<HomeScreenViewState> {

  HomeScreenStateNotifer() : super(const HomeScreenViewState.loading());

  ///Step 1 - Display the loading animation for displaying hi robot on home screen
  void init(){
    state = const HomeScreenViewState.loading();
    Future.delayed(Duration(seconds: ApplicationConstants.kAnimationLoadTime),(){
      state = const HomeScreenViewState.homeView();
    });
  }
}