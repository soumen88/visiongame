import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home/model/home_screen_view_state.dart';
import '../home/viewmodel/home_screen_state_notifier.dart';

final homeScreenProviders = StateNotifierProvider<HomeScreenStateNotifer, HomeScreenViewState>(
        (ref) => HomeScreenStateNotifer()
);
