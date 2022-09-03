import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visiongame/injector/injection.dart';
import 'package:visiongame/providers/provider.dart';

import '../../base/logger_utils.dart';
import '../../timer/timer_container.dart';
import '../triggers/game_triggers.dart';

class GameVolumeWidget extends HookConsumerWidget{
  final _TAG = "GameVolumeWidget";
  final _logger = locator<LoggerUtils>();
  final _gameTrigger = locator<GameTriggers>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timerNotifier = ref.watch(timerProvider.notifier);
    final voiceInputActiveStream = useStream(_gameTrigger.isVoiceInputEnabled.stream);
    final playerLifeStream = useStream(_gameTrigger.playerLifeEventNotifier.stream);
    bool isVoiceInputEnabled = voiceInputActiveStream.data != null && voiceInputActiveStream.data!;
    final playerImmutableStream = useStream(_gameTrigger.isPlayerImmutable.stream);
    if(playerImmutableStream.data != null){
      timerNotifier.startTimer();
    }

    return Stack(
      children: [
        Positioned(
          top: 30,
          left: 10,
          child: IconButton(
            onPressed: (){
              _gameTrigger.toggleVoiceInput();
            },
            icon: isVoiceInputEnabled ? Icon(
              Icons.mic_outlined,
              size: 40,
            ) : Icon(
              Icons.mic_off,
              size: 40,
            ),
          ),
        ),
        Positioned(
          bottom:10 ,
          right: 10,
          child: Container(
              width: 100,
              height: 100,
              child: TimerContainer(timerLabel: "Secs", durationLabel: "00",),
          )
        )
      ],
    );
  }

}