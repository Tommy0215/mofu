import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';

import 'backgrounds.dart';
import 'creature.dart';

import 'effect.dart';


void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame with TapDetector{
  late Creature mofu;

  @override
  Future<void> onLoad() async {
    add(Background(Backgrounds.forest2)); //background, must be added first

    mofu = Creature();
    add(mofu);
    mofu.startRandomMovement();
  }

  @override
  void onTapDown(TapDownInfo info) {
    final ripple = RippleEffect(info.eventPosition.global);
    add(ripple);

    final targetPosition = info.eventPosition.global;
    mofu.moveTo(targetPosition); // Move the creature to the tapped position
  }
}

