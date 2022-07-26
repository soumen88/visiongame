import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:visiongame/base/constants.dart';
import 'package:visiongame/enums/difficulty_level_enum.dart';
import 'package:visiongame/injector/injection.dart';

import '../../base/logger_utils.dart';
import '../triggers/game_triggers.dart';

class GameTrackerWidget extends HookConsumerWidget{
  final _logger = locator<LoggerUtils>();
  final _TAG = "GameTrackerWidget";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _gameTrigger = locator<GameTriggers>();
    final playerLifeStream = useStream(_gameTrigger.playerLifeEventNotifier.stream);
    final playerCoinStream = useStream(_gameTrigger.playerCoinsStream.stream);
    final gameDifficultyStream = useStream(_gameTrigger.gameDifficultyLevelStream.stream);

    return Stack(
      children: [
        Positioned(
            top: 30,
            right: 10,
            child: Row(
              children: [
                Image.asset(
                  "assets/images/shopping_bag.png",
                  width: 30,
                  height: 30,
                ),
                if(playerLifeStream.data != null)
                  Text("${playerCoinStream.data}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24
                  ),),
                if(gameDifficultyStream.data != null && gameDifficultyStream.data == DifficultyLevelEnums.EASY)
                  Text("/${ApplicationConstants.kLevelEasyCompletionCoins}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24
                  ),),
                if(gameDifficultyStream.data != null && gameDifficultyStream.data == DifficultyLevelEnums.MEDIUM)
                  Text("/${ApplicationConstants.kLevelMediumCompletionCoins}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24
                    ),),
                if(gameDifficultyStream.data != null && gameDifficultyStream.data == DifficultyLevelEnums.HARD)
                  Text("/${ApplicationConstants.kLevelEasyCompletionCoins}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24
                    ),),
              ],
            )
        ),
        Positioned(
            top: 30,
            right: 80,
            child: Row(
              children: [
                Image.asset(
                  "assets/images/heart.png",
                  width: 30,
                  height: 30,
                ),
                if(playerLifeStream.data != null)
                  Text("${playerLifeStream.data!.playerLivesLeft}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24
                  ),)
              ],
            )
        ),
      ],
    );
  }

}