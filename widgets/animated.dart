import 'package:flutter/material.dart';

class AnimatedDice extends StatelessWidget {
  final Animation<double> animation;
  final int diceNumber;

  const AnimatedDice({
    Key? key,
    required this.animation,
    required this.diceNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: animation.value,
          child: Image.asset(
            'images/dice$diceNumber.jpg',
            width: 50,
            height: 50,
          ),
        );
      },
    );
  }
}
