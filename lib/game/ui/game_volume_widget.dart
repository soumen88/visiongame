import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visiongame/injector/injection.dart';
import 'package:visiongame/providers/provider.dart';

import '../triggers/game_triggers.dart';

class GameVolumeWidget extends HookConsumerWidget{
  final _gameTrigger = locator<GameTriggers>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final voiceInputActiveStream = useStream(_gameTrigger.isVoiceInputEnabled.stream);
    bool isVoiceInputEnabled = voiceInputActiveStream.data != null && voiceInputActiveStream.data!;
    return Positioned(
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
    );
  }

}