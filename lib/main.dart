import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';
import 'dart:async';
import 'package:logging/logging.dart';

import 'background.dart';
import 'creature.dart';
import 'effect.dart';
import 'tap.dart';
import 'button.dart';  // Import the ButtonComponent
import 'audio_controller.dart';

void main() {
  runApp(GameWidget(game: MyGame()));
}

final Logger log = Logger('MyGame');

void setupLogging() {
  Logger.root.level = Level.ALL; // Set to Level.INFO or Level.WARNING to reduce output
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message}');
  });
}

class MyGame extends FlameGame {
  final AudioController _audioController = AudioController();
  late Creature mofu;
  late Background currentBackground;
  late BackgroundButton button;
  bool musicOn = false;

  @override
  Future<void> onLoad() async {
    await FlameAudio.audioCache.load('horror.wav');
    
    // Load default background
    currentBackground = Background(Backgrounds.horror1);
    add(currentBackground);

    // Load UI
    button = BackgroundButton(currentBackground.swicthBackground);
    add(button);

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