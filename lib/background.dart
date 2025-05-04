import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:mofu/main.dart';

enum Backgrounds {
  forest1,
  forest2,
  horror1
}

class Background extends PositionComponent with HasGameReference<MyGame> {

  Background(this.backgroundType){
    priority = 0;
  }

  late Backgrounds backgroundType;
  late SpriteComponent background;
  late RectangleComponent blackBackground;
  late List<Sprite> backgroundList;
  final values = Backgrounds.values;

  @override
  Future<void> onLoad() async {
    // Add black fill background
    blackBackground = RectangleComponent(
      size: game.size,
      paint: Paint()..color = Colors.black,
    );
    add(blackBackground);

    // Load sprites
    backgroundList = [];

    for (var bg in Backgrounds.values) {
      Sprite bgSprite = await Sprite.load(backgroundPath(bg));
      backgroundList.add(bgSprite);
    }

    Sprite sprite = await Sprite.load(backgroundPath(backgroundType));
    background = SpriteComponent(sprite: sprite);
    add(background);

    _resizeHybrid(game.size);
  }

  void swicthBackground(){
    // remove(background);
    final nextIndex = (backgroundType.index + 1) % values.length;
    backgroundType = values[nextIndex];
    add(SpriteComponent(sprite: backgroundList[nextIndex]));
    log.info("changed background");
  }

  String backgroundPath(Backgrounds bg) {
    switch (bg) {
      case Backgrounds.forest1:
        return 'bg_forest1.jpeg';
      case Backgrounds.forest2:
        return 'bg_forest2.jpeg';
      case Backgrounds.horror1:
        return 'bg_horror1.jpeg';
    }
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
    _resizeHybrid(canvasSize);
  }

  void _resizeHybrid(Vector2 canvasSize) {
    blackBackground.size = canvasSize;

    final imageSize = background.sprite!.srcSize;

    // Hybrid strategy:
    // - Always show full height (so use scaleY)
    // - Allow cropping on the sides (so ignore scaleX if it's smaller)
    final scaleY = canvasSize.y / imageSize.y;
    background.size = imageSize * scaleY;

    // Horizontally center (crop if too wide)
    final x = (canvasSize.x - background.size.x) / 2;
    background.position = Vector2(x, 0);
  }
}



