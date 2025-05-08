import 'package:flame/game.dart';
import 'package:flappy_dash/utils/screen_size.dart';

class Config {
  static double dashSize = 70.0;
  static double pipeWidth = 75.0;
  static double pipeHeight = 900.0;
  static double pipesDistance = 370.0;
  static double pipePairGap = Config.dashSize * 2.5;
  static double pipePairSpeed = 200;
  static Vector2 hiddenCoinSize = Vector2(pipePairGap / 2, pipePairGap / 2);
  static Vector2 gravity = Vector2(0, 1400.0);
  static Vector2 jumpForce = Vector2(0, -500);

  ///Since the above variables are static, we can't use the extension methods directly upon declaring them.
  ///Becuase the ScreenSize is not initialized at that time.
  static void updateConfigValues() {
    dashSize = 70.w();
    pipeWidth = 75.w();
    pipeHeight = screenSize.height;
    pipesDistance = 370.w();
    pipePairGap = Config.dashSize * 2.5;
    pipePairSpeed = 200.w();
    hiddenCoinSize = Vector2(pipePairGap / 2, pipePairGap / 2);
    gravity = Vector2(0, 1400.h());
    jumpForce = Vector2(0, -500.h());
  }
}
