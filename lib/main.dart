import 'package:flutter/material.dart';
import 'package:tic_tac_toe/home.dart';

void main() {
  runApp(const TicTacToeGame());
}

class TicTacToeGame extends StatefulWidget {
  const TicTacToeGame({super.key});

  @override
  State<TicTacToeGame> createState() => _TicTacToeGameState();
}

class _TicTacToeGameState extends State<TicTacToeGame> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
