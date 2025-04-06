import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'backgrounds.dart';
import 'creature.dart';
import 'effect.dart';
import 'tap.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame {
  late Creature mofu;

  @override
  Future<void> onLoad() async {
    add(Background(Backgrounds.forest2)); // background first

    mofu = Creature();
    add(mofu);
    mofu.startRandomMovement();

    // Add a full-screen tappable overlay
    add(TapArea(
    onSingleTap: (position) {
      add(RippleEffect(position));
      mofu.moveTo(position);
    },
    onDoubleTap: (position) {
      mofu.speedUp();
    },
  ));
  }
}
