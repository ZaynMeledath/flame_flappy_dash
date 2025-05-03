import 'package:flame/game.dart';

class Config {
  static const dashSize = 70.0;
  static const pipeWidth = 82.0;
  static const pipesDistance = 400.0;
  static final Vector2 gravity = Vector2(0, 1400.0);
  static final Vector2 jumpForce = Vector2(0, -500);
}
