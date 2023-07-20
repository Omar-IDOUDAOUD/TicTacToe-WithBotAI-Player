import 'dart:math';

import 'package:tic_tac_toe/enter_player_name.dart';

class BotAi {
  final List<int> playerPositions;
  final List<int> botPositions;
  final BotDifficulty difficulty;
  int _difficultyLevel = 1;

  BotAi({
    required this.playerPositions,
    required this.botPositions,
    required this.difficulty,
  }) : _difficultyLevel = difficulty == BotDifficulty.Easy
            ? 1
            : difficulty == BotDifficulty.Medium
                ? 2
                : 3;
  final _winningCombinations = [
    [0, 4, 8],
    [2, 4, 6],
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
  ];

  int getDecision() {
    int? decision = null;

    if (_difficultyLevel == 1) {
      decision = _botCloseToWinResult() ?? _playerCloseToWinResult(); //1
      print('decision 1 : $decision');
    }
    if (_difficultyLevel <= 3 && decision == null) {
      decision = _isCenterEmpty() ? 4 : null; //3
      print('decision 2 : $decision');
    }
    if (_difficultyLevel <= 2 && decision == null) {
      decision = _findBestMove(); //2
      print('decision 3 : $decision');
    }
    if (_difficultyLevel == 1 && decision == null) {
      decision = _randomMove(); //1
      print('decision 4 : $decision');
    }
    return decision!;
  }

  int _randomMove() {
    List allCombinations = [];
    _winningCombinations.forEach((element) {
      allCombinations.addAll(element);
    });
    allCombinations.removeWhere(
        (element) => (playerPositions + botPositions).contains(element));
    var randomMove;
    try {
      randomMove =
          allCombinations[Random.secure().nextInt(allCombinations.length - 1)];
    } catch (e) {
      randomMove = 0; 
    }
    return randomMove;
  }

  int? _findBestMove() {
    var availableLines = _findAvailableLines();
    if (availableLines == null) return null;
    var bestLine = _findBestLine(availableLines);
    var bestMove = _findMissinPositionFromLine(bestLine);

    // print('_findEmptyLines $availableLines'); //=> randomPos
    // print('_findBestLine $bestLine');
    // print('_findMissinPositionFromLine: $bestMove');

    return bestMove;
  }

  int _findMissinPositionFromLine(List<int> line) {
    var missingPosition = 0;
    for (var position in line) {
      if (!botPositions.contains(position)) {
        missingPosition = position;
        break;
      }
    }
    return missingPosition;
  }

  List<int> _findBestLine(List<List<int>> availableLines) {
    List<int> bestLine = availableLines.first;
    int bestLineFilledPositions = 0;
    for (var line in availableLines) {
      //[0, 1, 2]
      List<int> currentLine = [];
      int currentLineFilledPosotions = 0;
      for (var position in botPositions) {
        // 1
        if (line.contains(position)) {
          currentLineFilledPosotions++;
          currentLine = line;
        }
      }
      if (currentLineFilledPosotions > bestLineFilledPositions) {
        bestLine = currentLine;
        bestLineFilledPositions = currentLineFilledPosotions;
        // print('---____________${currentLine}');
      }
    }
    return bestLine;
  }

  List<List<int>>? _findAvailableLines() {
    List<List<int>> emptyLines = [];
    List<int> currentBuildingLine = [];

    for (var combination in _winningCombinations) {
      // [0,1,2]

      for (var element in combination) {
        // 0
        if (!playerPositions.contains(element))
          currentBuildingLine.add(element);
        else
          break;
      }
      if (currentBuildingLine.length == 3) {
        // print('--------$currentBuildingLine');
        emptyLines.add(currentBuildingLine.toList());
      }
      currentBuildingLine.clear();
    }
    return emptyLines.isEmpty ? null : emptyLines;
  }

  bool _isCenterEmpty() => !(playerPositions + botPositions).contains(4);

  int? _botCloseToWinResult() {
    List<int> positions = [];
    int? missingPosition;
    for (var combination in _winningCombinations) {
      positions.clear();
      for (var element in combination) {
        if (botPositions.contains(element)) {
          positions.add(element);
        } else {
          missingPosition = element;
        }
        if (playerPositions.contains(element)) {
          positions.clear();
          missingPosition = null;
          break;
        }
      }
      if (positions.length == 2)
        break;
      else {
        positions.clear();
        missingPosition = null;
      }
    }
    return missingPosition;
  }

  int? _playerCloseToWinResult() {
    List<int> positions = [];
    int? missingPosition;
    for (var combination in _winningCombinations) {
      positions.clear();
      for (var element in combination) {
        if (playerPositions.contains(element)) {
          positions.add(element);
        } else {
          missingPosition = element;
        }
        if (botPositions.contains(element)) {
          positions.clear();
          missingPosition = null;
          break;
        }
      }
      if (positions.length == 2)
        break;
      else {
        positions.clear();
        missingPosition = null;
      }
    }
    return missingPosition;
  }
}
