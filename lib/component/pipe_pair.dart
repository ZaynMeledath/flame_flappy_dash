import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/component/pipe.dart';
import 'package:flappy_dash/src/configuration.dart';
import 'hidden_coin.dart';

class PipePair extends PositionComponent
    with HasGameRef, FlameBlocReader<GameCubit, GameState> {
  PipePair({
    required super.position,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addAll([
      Pipe(
        isFlipped: false,
        position: Vector2(0, Config.pipePairGap / 2),
      ),
      Pipe(
        isFlipped: true,
        position: Vector2(0, -(Config.pipePairGap / 2)),
      ),
      HiddenCoin(
        position: Vector2(Config.pipeWidth * .95, 0),
      ),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    switch (bloc.state.currentPlayingState) {
      case PlayingState.paused:
      case PlayingState.gameOver:
      case PlayingState.idle:
        // We don't move it
        break;
      case PlayingState.playing:
        position.x -= Config.pipePairSpeed * dt;

        if (position.x < -(gameRef.size.x / 2 + Config.pipeWidth)) {
          removeFromParent();
        }
        break;
    }
  }
}
