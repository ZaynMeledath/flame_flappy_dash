import 'dart:ui';

import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            color: Colors.black54,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'GAME OVER!',
                    style: TextStyle(
                      color: const Color(0xFFFFCA00),
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * .116,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Score: ${state.currentScore}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * .052,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 60),
                  ElevatedButton(
                    onPressed: () => context.read<GameCubit>().restartGame(),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'PLAY AGAIN!',
                        style: TextStyle(
                          fontSize: screenWidth * .052,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
