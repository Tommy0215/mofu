import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:mofu/main.dart';

class BackgroundButton extends ButtonComponent with HasGameReference<MyGame>{
  final void Function() onPressed;

  BackgroundButton(this.onPressed)
      : super(
          anchor: Anchor.topRight,
          priority: 10,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Position is to be initialized after retrieving the game reference
    position = Vector2(game.size.x - 20, 20);

    // Loading the button image
    final nextButton = await Sprite.load('next_sign.png'); 
    button = SpriteComponent(
      sprite: nextButton,
      size: nextButton.srcSize * 0.3
    );  
  }


  // @override
  // void onGameResize(Vector2 canvasSize) {
  //   super.onGameResize(canvasSize);
  //   position = Vector2(game.size.x - 20, 20);
  // }

}