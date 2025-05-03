import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'dart:async';

import 'backgrounds.dart';
import 'creature.dart';
import 'effect.dart';
import 'tap.dart';
// import 'button.dart';  // Import the ButtonComponent

import 'package:flame_audio/flame_audio.dart';
import 'audio_controller.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

class MyGame extends FlameGame {
  final AudioController _audioController = AudioController();
  late Creature mofu;
  late Background currentBackground;
  bool musicOn = false;

  @override
  Future<void> onLoad() async {
    await FlameAudio.audioCache.load('horror.wav');
    
    // Load default background
    currentBackground = Background(Backgrounds.forest1);
    add(currentBackground);

    // Load UI
    

    // Load mofu and start the movement
    mofu = Creature();
    add(mofu);
    mofu.startRandomMovement();

    // Add a full-screen tappable overlay
    add(TapArea(
      onSingleTap: (position) {
        add(RippleEffect(position));
        mofu.moveTo(position);
        _audioController.playLoopingMusicWithFadeIn('horror.wav', maxVolume: 0.8);
      },
      onDoubleTap: (position) {
        mofu.speedUp();
      },
    ));
  }
}