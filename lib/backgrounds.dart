import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class Backgrounds {
  static const String forest1 = 'bg_forest.jpeg';
  static const String forest2 = 'bg_forest2.jpeg';
}

enum Backgroundss {
  forest1,
  forest2
}

class Background extends PositionComponent with HasGameReference<FlameGame> {
  final String path;
  late SpriteComponent spriteComponent;
  late RectangleComponent blackBackground;

  Background(this.path){
    priority = 0;
  }

  @override
  Future<void> onLoad() async {
    // Add black fill background
    blackBackground = RectangleComponent(
      size: game.size,
      paint: Paint()..color = Colors.black,
    );
    add(blackBackground);

    // Load sprite
    final sprite = await Sprite.load(path);
    spriteComponent = SpriteComponent(sprite: sprite);
    add(spriteComponent);

    _resizeHybrid(game.size);
  }

  String backgroundPath(Backgroundss bg) {
    switch (bg) {
      case Backgroundss.forest1:
        return 'bg_forest.jpeg';
      case Backgroundss.forest2:
        return 'bg_forest2.jpeg';
    }
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    _resizeHybrid(canvasSize);
  }

  void _resizeHybrid(Vector2 canvasSize) {
    blackBackground.size = canvasSize;

    final imageSize = spriteComponent.sprite!.srcSize;

    // Hybrid strategy:
    // - Always show full height (so use scaleY)
    // - Allow cropping on the sides (so ignore scaleX if it's smaller)
    final scaleY = canvasSize.y / imageSize.y;
    spriteComponent.size = imageSize * scaleY;

    // Horizontally center (crop if too wide)
    final x = (canvasSize.x - spriteComponent.size.x) / 2;
    spriteComponent.position = Vector2(x, 0);
  }
}



