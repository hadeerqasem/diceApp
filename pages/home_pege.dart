import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/animated.dart';

class DiceRollerPage extends StatefulWidget {
  @override
  _DiceRollerPageState createState() => _DiceRollerPageState();
}

class _DiceRollerPageState extends State<DiceRollerPage> with SingleTickerProviderStateMixin {
  int _numDice = 1;
  List<int> _diceResults = [1];
  final Random _random = Random();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _rollDice() {
    _controller.forward(from: 0).then((_) {
      setState(() {
        _diceResults = List.generate(_numDice, (index) => _random.nextInt(6) + 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dice Roller')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _diceResults
                  .map((result) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimatedDice(
                          animation: _animation,
                          diceNumber: result,
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _rollDice,
              child: Text('Roll Dice'),
            ),
            SizedBox(height: 16),
            _buildDiceSelectionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildDiceSelectionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDiceButton(1),
        SizedBox(width: 10),
        _buildDiceButton(2),
        SizedBox(width: 10),
        _buildDiceButton(3),
      ],
    );
  }

  Widget _buildDiceButton(int count) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _numDice = count;
          _diceResults = List.filled(_numDice, 1);
        });
      },
      child: Text('$count Die${count > 1 ? 's' : ''}'),
      style: ElevatedButton.styleFrom(
        backgroundColor: _numDice == count ? Colors.red : Colors.grey,
      ),
    );
  }
}
