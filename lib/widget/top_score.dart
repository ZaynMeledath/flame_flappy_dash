import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopScore extends StatelessWidget {
  const TopScore({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.topCenter,
          child: Text(
            state.currentScore.toString(),
            style: TextStyle(
              color: const Color.fromARGB(255, 0, 78, 151),
              fontSize: screenWidth * .09,
              height: 1.2,
            ),
          ),
        );
      },
    );
  }
}
