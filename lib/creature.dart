import 'dart:math';
import 'package:flame/components.dart';

class Creature extends SpriteComponent with HasGameReference {
  final double _default_speed = 200;
  final Random _random = Random();
  double _actionTimer = 0;
  Vector2 _velocity = Vector2.zero();
  bool _isMoving = false;
  bool _isRandomMoving = false; // Flag to check if it's moving randomly
  late Vector2 _targetPosition; // Target position for tap-to-move
  double _speed = 200; // Movement speed
  final double _maxRadius = 200; // Max random movement radius

  late Sprite _mofu;
  late Sprite _happy_mofu;

  Creature() : super(size: Vector2.all(150)) {
    // Set the anchor to the center of the sprite
    anchor = Anchor.center;
    priority = 1;
  }

  @override
  Future<void> onLoad() async {
    _mofu = await Sprite.load('mofu.png');
    _happy_mofu = await Sprite.load('mofu_happy.png');

    sprite = _mofu;

    position = Vector2(200, 200); // Starting position (center of the creature)
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Handle random movement if enabled
    if (_isRandomMoving) {
      _actionTimer -= dt;

      if (_actionTimer <= 0) {
        _actionTimer = 1 + _random.nextDouble() * 2;
        if (_random.nextDouble() < 0.2) {
          // 20% chance to stop random movement
          _isMoving = false;
          _velocity = Vector2.zero();
        } else {
          // 80% chance to continue random movement
          _isMoving = true;
          final dx = (_random.nextDouble() - 0.5) * _maxRadius;
          final dy = (_random.nextDouble() - 0.5) * _maxRadius;
          _velocity = Vector2(dx, dy);
        }
      }

      // For any movement the creature stays inside the screen
      if (_isMoving) {
        position += _velocity * dt;
        position.clamp(Vector2.zero(), game.size);
      }
    }

    // Handle direct movement when tapping
    if (!_isRandomMoving) {
      // Move towards the target position (tap position)
      Vector2 direction = _targetPosition - position;
      double distance = direction.length;

      if (distance > 1) {
        direction = direction.normalized();
        position += direction * _speed * dt;
      } else {
        _isMoving = false; // Stop moving when target is reached
        _isRandomMoving = true; // Restart random movement after reaching target
        sprite = _mofu;
        _speed = _default_speed;
      }
    }
  }

  // Function to set the target position when tapped
  void moveTo(Vector2 target) {
    _targetPosition = target;
    _isMoving = true;
    _isRandomMoving = false; // Stop random movement when tapping
    sprite = _happy_mofu;
  }

  // Speeds up the creature
  void speedUp(){
    if (_speed <= 300){
      _speed += 100;
    }
  }

  // Start random movement when the game starts or after a tap is finished
  void startRandomMovement() {
    _isRandomMoving = true;
  }
}