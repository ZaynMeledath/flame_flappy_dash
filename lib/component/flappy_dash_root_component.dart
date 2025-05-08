import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/flappy_dash_game.dart';
import 'package:flappy_dash/src/configuration.dart';
import 'package:flappy_dash/utils/screen_size.dart';
import 'package:flutter/animation.dart';

import 'dash.dart';
import 'dash_parallax_background.dart';
import 'pipe_pair.dart';

class FlappyDashRootComponent extends Component
    with HasGameRef<FlappyDashGame>, FlameBlocReader<GameCubit, GameState> {
  late Dash _dash;
  late PipePair _lastPipe;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(DashParallaxBackground());
    add(_dash = Dash());
    _generatePipes(
      fromX: 350,
    );
  }

  void _generatePipes({
    int count = 5,
    double fromX = 0.0,
  }) {
    for (int i = 0; i < count; i++) {
      final area = screenSize.height * .65;
      final y = (Random().nextDouble() * area) - (area / 2);
      add(_lastPipe = PipePair(
        position: Vector2(fromX + (i * Config.pipesDistance), y),
      ));
    }
  }

  void onSpaceDown() {
    _checkToStart();
    _dash.jump();
  }

  void onTapDown(TapDownEvent event) {
    _checkToStart();
    _dash.jump();
  }

  void _checkToStart() {
    if (bloc.state.currentPlayingState.isIdle) {
      _dash.add(MoveByEffect(
        Vector2(-gameRef.size.x * .25, 0),
        EffectController(
          duration: .5,
          curve: Curves.easeInOut,
        ),
      ));
      bloc.startPlaying();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_dash.x >= _lastPipe.x) {
      _generatePipes(
        fromX: Config.pipesDistance,
      );
    }
    // game.camera.viewfinder.zoom = 1.0;
  }
}
