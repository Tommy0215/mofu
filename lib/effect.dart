import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';

class RippleEffect extends CircleComponent {
  final double _maxRadius;
  double _elapsedTime = 0;
  final double _duration = 0.6;
  final Paint _paint = BasicPalette.white.withAlpha(100).paint();

  RippleEffect(Vector2 position, {double maxRadius = 50}) 
      : _maxRadius = maxRadius,
        super(
          radius: 0,
          paint: BasicPalette.white.paint(),
          anchor: Anchor.center,
        ) {
    this.position = position;
    paint = _paint;
    priority = 2;
  }


  @override
  void update(double dt) {
    super.update(dt);
    _elapsedTime += dt;

    double t = _elapsedTime / _duration;
    radius = _maxRadius * t;

    // Set transparency using withAlpha (0 = transparent, 255 = opaque)
    final alpha = ((1 - t) * 255).clamp(0, 50).toInt();
    paint.color = paint.color.withAlpha(alpha);

    if (t >= 1) {
      removeFromParent();
    }
  }
}