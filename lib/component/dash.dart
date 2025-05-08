import 'dart:ui';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/component/hidden_coin.dart';
import 'package:flappy_dash/component/pipe.dart';
import 'package:flappy_dash/flappy_dash_game.dart';
import 'package:flappy_dash/src/configuration.dart';

class Dash extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef<FlappyDashGame>,
        FlameBlocReader<GameCubit, GameState> {
  Dash()
      : super(
          position: Vector2(0, 0),
          size: Vector2.all(Config.dashSize),
          anchor: Anchor.center,
          priority: 10,
        );

  late Sprite _dashSprite;

  Vector2 _velocity = Vector2(0, 0);

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _dashSprite = await Sprite.load('dash.png');
    final radius = size.x / 2;
    final center = size / 2;
    add(CircleHitbox(
      radius: radius * 0.75,
      position: center * 1.1,
      anchor: Anchor.center,
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (bloc.state.currentPlayingState.isNotPlaying) {
      return;
    }

    _velocity += Config.gravity * dt;
    position += _velocity * dt;

    if (position.y > (gameRef.size.y / 2) + (size.y / 2) ||
        position.y < -(gameRef.size.y / 2) + (size.y / 2)) {
      bloc.gameOver();
    }
  }

  void jump() {
    if (bloc.state.currentPlayingState.isNotPlaying) {
      return;
    }
    _velocity = Config.jumpForce;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _dashSprite.render(
      canvas,
      size: size,
    );
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (bloc.state.currentPlayingState.isNotPlaying) {
      return;
    }
    if (other is HiddenCoin) {
      bloc.increaseScore();
      other.removeFromParent();
    } else if (other is Pipe) {
      bloc.gameOver();
    }
  }
}
