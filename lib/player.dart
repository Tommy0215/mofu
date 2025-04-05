import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/services.dart';

class Player extends SpriteComponent with KeyboardHandler, HasGameRef<FlameGame> {
  final double speed = 200; // Speed of movement
  final double jumpForce = 300; // Jump force
  final double gravity = 600; // Gravity
  Vector2 velocity = Vector2.zero();
  bool isJumping = false;

  Player({super.position})
      : super(
          size: Vector2.all(200), // 200x200
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('mofu.png');
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Apply gravity
    if (isJumping) {
      velocity.y += gravity * dt;
    }

    // Apply movement
    position += velocity * dt;

    // Prevent falling below ground (assuming ground at y = 500)
    if (position.y > 500) {
      position.y = 500;
      isJumping = false;
      velocity.y = 0;
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    velocity.x = 0; // Reset horizontal velocity

    if (keysPressed.contains(LogicalKeyboardKey.keyA)) {
      velocity.x = -speed;
    } else if (keysPressed.contains(LogicalKeyboardKey.keyD)) {
      velocity.x = speed;
    }

    if (keysPressed.contains(LogicalKeyboardKey.space) && !isJumping) {
      velocity.y = -jumpForce;
      isJumping = true;
    }

    return true; // Event handled
  }
}