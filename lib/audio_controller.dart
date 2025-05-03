import 'dart:async';
import 'package:flame_audio/flame_audio.dart';

class AudioController {
  bool _musicOn = false;
  double maxVolume = 1;

  Future<void> playLoopingMusicWithFadeIn(
    String fileName, {
    Duration fadeDuration = const Duration(seconds: 5),
    double? maxVolume,
  }) async {
    if (_musicOn) return;
    _musicOn = true;

    final targetVolume = maxVolume ?? this.maxVolume;

    await FlameAudio.audioCache.load(fileName);
    FlameAudio.loop(fileName).then((player) {
      double volume = 0.0;
      player.setVolume(volume);

      const steps = 20;
      final stepTime = fadeDuration.inMilliseconds ~/ steps;
      final increment = targetVolume / steps;

      Timer.periodic(Duration(milliseconds: stepTime), (timer) {
        volume += increment;
        if (volume >= targetVolume) {
          volume = targetVolume;
          timer.cancel();
        }
        player.setVolume(volume);
      });
    });
  }
}