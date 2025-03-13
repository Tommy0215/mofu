//flutter build-in
import 'package:flutter/material.dart';
//flame
import 'package:flame/components.dart';
import 'package:flame/game.dart';
//

void main() {
  runApp(
    GameWidget(
      game: FlameGame(world: MyWorld()))
  );
}

class MyWorld extends World {
  @override
  Future<void> onLoad() async {
    add(Player(position: Vector2(0, 0)));
  }
}

class Player extends SpriteComponent {
  Player({super.position}) :
    super(size: Vector2.all(200), anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('player.png');
  }
}