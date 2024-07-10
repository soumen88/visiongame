import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visiongame/difficultylevel/model/difficulty_level_view_state.dart';
import 'package:visiongame/difficultylevel/viewmodel/difficulty_level_state_notifier.dart';
import 'package:visiongame/game/models/game_screen_view_state.dart';
import 'package:visiongame/game/viewmodel/game_view_state_notifier.dart';
import 'package:visiongame/home/model/locale_state.dart';
import 'package:visiongame/home/viewmodel/locale_state_notifier.dart';
import 'package:visiongame/timer/model/timer_view_state.dart';
import 'package:visiongame/timer/viewmodel/timer_state_notifier.dart';

import '../home/model/home_screen_view_state.dart';
import '../home/viewmodel/home_screen_state_notifier.dart';

final homeScreenProviders = StateNotifierProvider<HomeScreenStateNotifer, HomeScreenViewState>(
        (ref) => HomeScreenStateNotifer()
);

final difficultyScreenProviders = StateNotifierProvider<DifficultyLevelStateNotifier, DifficultyLevelViewState>(
        (ref) => DifficultyLevelStateNotifier()
);

final timerProvider = StateNotifierProvider<TimerStateNotifier, TimerViewState>(
        (ref) => TimerStateNotifier()
);

final gameProvider = StateNotifierProvider<GameViewStateNotifier, GameScreenViewState>(
        (ref) => GameViewStateNotifier()
);

final languageProvider = StateNotifierProvider<LocaleStateNotifier, LocaleState>(
        (ref) => LocaleStateNotifier()
);
