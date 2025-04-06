import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'main.dart'; // Only needed if using HasGameRef<MyGame>

class TapArea extends PositionComponent with TapCallbacks, HasGameRef<MyGame> {
  final void Function(Vector2 position) onSingleTap;
  final void Function(Vector2 position) onDoubleTap;

  TapArea({
    required this.onSingleTap,
    required this.onDoubleTap,
  });

  static const doubleTapThreshold = 0.3; // seconds
  double lastTapTime = 0;

  @override
  Future<void> onLoad() async {
    size = gameRef.size;
    position = Vector2.zero();
  }

  @override
    void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    size = canvasSize;
  }

  @override
  void onTapDown(TapDownEvent event) {
    final now = gameRef.currentTime();
    final delta = now - lastTapTime;
    lastTapTime = now;

    final position = event.canvasPosition;

    if (delta < doubleTapThreshold) {
      onDoubleTap(position);
    } else {
      onSingleTap(position);
    }
  }
}