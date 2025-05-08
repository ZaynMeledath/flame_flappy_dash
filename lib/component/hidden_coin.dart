import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flappy_dash/src/configuration.dart';

class HiddenCoin extends PositionComponent {
  HiddenCoin({
    required super.position,
  }) : super(
          size: Config.hiddenCoinSize,
          anchor: Anchor.center,
        );

  @override
  void onLoad() {
    super.onLoad();
    add(CircleHitbox(
      collisionType: CollisionType.passive,
    ));
  }
}
