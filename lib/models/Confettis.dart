import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class Confettis extends StatelessWidget {
  const Confettis({
    Key key,
    @required ConfettiController controllerCenterRight,
  })  : _controllerCenterRight = controllerCenterRight,
        super(key: key);

  final ConfettiController _controllerCenterRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ConfettiWidget(
        confettiController: _controllerCenterRight,
        blastDirectionality: BlastDirectionality.explosive,
        shouldLoop: false,
        colors: const [
          Colors.green,
          Colors.blue,
          Colors.pink,
          Colors.orange,
          Colors.purple
        ],
      ),
    );
  }
}
