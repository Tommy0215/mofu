import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'backgrounds.dart';
import 'creature.dart';
import 'effect.dart';

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

/// A full-screen invisible tappable component
class TapArea extends PositionComponent with TapCallbacks, HasGameRef<MyGame> {
  final void Function(Vector2 position) onSingleTap;
  final void Function(Vector2 position) onDoubleTap;

  TapArea({
    required this.onSingleTap,
    required this.onDoubleTap,
  });

  static const doubleTapThreshold = 0.3; // Seconds
  double lastTapTime = 0;

  @override
  Future<void> onLoad() async {
    size = gameRef.size;
    position = Vector2.zero();
  }

  @override
  void onTapDown(TapDownEvent event) {
    final now = gameRef.currentTime(); // Game time in seconds
    final delta = now - lastTapTime;
    lastTapTime = now;

    final position = event.canvasPosition;

    if (delta < doubleTapThreshold) {
      onSingleTap(position);
      onDoubleTap(position);
    } else {
      onSingleTap(position);
    }
  }
}