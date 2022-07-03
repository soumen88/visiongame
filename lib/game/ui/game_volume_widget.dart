import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameVolumeWidget extends HookConsumerWidget{
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Positioned(
        top: 30,
        left: 10,
        child: Image.asset(
          "assets/images/soundon.png",
          width: 60,
          height: 60,
        ),
    );
  }

}