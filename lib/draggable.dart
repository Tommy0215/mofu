//flutter
import 'package:flutter/material.dart';
//flame
import 'package:flame/components.dart';
import 'package:flame/events.dart';


class DraggableImage extends SpriteComponent with DragCallbacks {
  DraggableImage({super.size});

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('mofu.png');
  }

  @override
  void onDragUpdate(DragUpdateEvent event) => position += event.localDelta;
}

class DraggableShape extends PositionComponent with DragCallbacks{
  DraggableShape({Vector2? position}):
    super(
      size: Vector2.all(100),
      position: position ?? Vector2.zero()
    );
  @override
  void render(Canvas canvas){
    super.render(canvas);
    final paint = Paint()..color = const Color(0xFFFFFFFF); // White color
    canvas.drawRect(size.toRect(), paint);
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position += event.localDelta; // Move the square while dragging
  }
}