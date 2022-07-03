import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visiongame/game/models/game_screen_view_state.dart';
import 'package:visiongame/game/viewmodel/game_view_state_notifier.dart';
import 'package:visiongame/timer/model/timer_view_state.dart';
import 'package:visiongame/timer/viewmodel/timer_state_notifier.dart';

import '../home/model/home_screen_view_state.dart';
import '../home/viewmodel/home_screen_state_notifier.dart';

final homeScreenProviders = StateNotifierProvider<HomeScreenStateNotifer, HomeScreenViewState>(
        (ref) => HomeScreenStateNotifer()
);

final timerProvider = StateNotifierProvider<TimerStateNotifier, TimerViewState>(
        (ref) => TimerStateNotifier()
);

final gameProvider = StateNotifierProvider<GameViewStateNotifier, GameScreenViewState>(
        (ref) => GameViewStateNotifier()
);
