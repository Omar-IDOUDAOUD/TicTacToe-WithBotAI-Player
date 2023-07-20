import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tic_tac_toe/bot_ai.dart';
import 'package:tic_tac_toe/constants/colors.dart';
import 'package:tic_tac_toe/enter_player_name.dart';
import 'package:tic_tac_toe/widgets/scaf_bacround.dart';

class PlayerData {
  final String Name;
  final String AvatarPath;

  PlayerData({required this.Name, required this.AvatarPath});
}

class PlayBoard extends StatefulWidget {
  const PlayBoard({super.key, required this.playType, this.botDifficulty});
  final PlayType playType;
  final BotDifficulty? botDifficulty;
  @override
  State<PlayBoard> createState() => _PlayBoardState();
}

class _PlayBoardState extends State<PlayBoard> {
  late final PlayerData _playerOneDt;
  late final PlayerData _playerTwoDt;
  late int _currentPlayer;

  final _winningConbinations = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];
  final List<int> _p1Positions = []; //player
  final List<int> _p2Positions = []; //bot

  //////////////////////BOTPLAY-SIDE/////////////////////////
  BotAi? botPlayer;

  Future<int> _botPlay() async {
    await Future.delayed(Duration(milliseconds: 500));
    botPlayer ??= BotAi(
      playerPositions: _p1Positions,
      botPositions: _p2Positions,
      difficulty: widget.botDifficulty!,
    );
    final move = botPlayer!.getDecision();
    // await Future.delayed(Duration(microseconds: 500));
    _p2Positions.add(move);
    _checkWinner();
    _changeCurrentPlayer();
    return move;
  }

  //////////////////////BOTPLAY-SIDE/////////////////////////

  FutureOr<void> _onPlay(p) async {
    if (_currentPlayer == 1 && !_p2Positions.contains(p)) {
      _p1Positions.add(p);
    } else if (_currentPlayer == 2 && !_p1Positions.contains(p)) {
      _p2Positions.add(p);
    }

    _checkWinner(); 
    if (_gameOver) return;  
    _changeCurrentPlayer();
    if (widget.playType == PlayType.PlayerVsBot && _currentPlayer == 2)
      _botPlay();
  }

  void _changeCurrentPlayer() {
    setState(() {
      _currentPlayer = _currentPlayer == 1 ? 2 : 1;
    });
  }

  List<int>? _winningCells;

  int _checkWinner() {
    for (var combination in _winningConbinations) {
      if (_p1Positions.contains(combination[0]) &&
          _p1Positions.contains(combination[1]) &&
          _p1Positions.contains(combination[2])) {
        _winningCells = combination;
        // print('player 1 win------------------------------');
        _gameOverDialog();
        return 1;
      } else if (_p2Positions.contains(combination[0]) &&
          _p2Positions.contains(combination[1]) &&
          _p2Positions.contains(combination[2])) {
        _winningCells = combination;
        // print('player 1 win------------------------------');
        _gameOverDialog();
        return 2;
      }
    }
    return 0;
  }

  bool _gameOver = false;

  void _gameOverDialog() {
    setState(() {
      _gameOver = true;
    });
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    this._playerOneDt = PlayerData(
        Name: 'Robert', AvatarPath: 'assets/icons/emojis/emoji2.png');
    this._playerTwoDt =
        PlayerData(Name: 'Bob', AvatarPath: 'assets/icons/emojis/emoji14.png');
    this._currentPlayer = Random.secure().nextBool() ? 1 : 2;
    if (widget.playType == PlayType.PlayerVsBot && _currentPlayer == 2)
      _botPlay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            // padding: EdgeInsets.only(top: 15, right: 15),
            icon: SvgPicture.asset(
              'assets/icons/ic_fluent_dismiss_circle_24_filled.svg',
              color: Colors.white,
              height: 30,
              alignment: Alignment.centerRight,
            ),
          ),
        ],
      ),
      body: ScafBackround(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              CurrentPlayerIndexRow(
                playerOneDt: _playerOneDt,
                playerTwoDt: _playerTwoDt,
                currentPlayerNum: _currentPlayer,
              ),
              SizedBox(
                height: 10,
              ),
              PlayBoard3x3(
                OnPlay: _onPlay,
                currentPlayer: _currentPlayer,
                p1Positions: _p1Positions,
                p2Positions: _p2Positions,
                avatar1: _playerOneDt.AvatarPath,
                avatar2: _playerTwoDt.AvatarPath,
                winCells: _winningCells,
                blockInsert: (widget.playType == PlayType.PlayerVsBot &&
                        _currentPlayer == 2) ||
                    _gameOver,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CurrentPlayerIndexRow extends StatefulWidget {
  const CurrentPlayerIndexRow(
      {super.key,
      required this.playerOneDt,
      required this.playerTwoDt,
      required this.currentPlayerNum});

  final PlayerData playerOneDt;
  final PlayerData playerTwoDt;
  final int currentPlayerNum;

  @override
  State<CurrentPlayerIndexRow> createState() => _CurrentPlayerIndexRowState();
}

class _CurrentPlayerIndexRowState extends State<CurrentPlayerIndexRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CurrentPlayerIndex(
            plrData: widget.playerOneDt,
            plrNumber: 1,
            currentPlayerNum: widget.currentPlayerNum),
        SizedBox(
          width: 7,
        ),
        CurrentPlayerIndex(
            plrData: widget.playerTwoDt,
            plrNumber: 2,
            currentPlayerNum: widget.currentPlayerNum),
      ],
    );
  }
}

class CurrentPlayerIndex extends StatefulWidget {
  const CurrentPlayerIndex(
      {super.key,
      required this.plrData,
      required this.plrNumber,
      required this.currentPlayerNum});

  final PlayerData plrData;
  final int plrNumber;
  final int currentPlayerNum;

  @override
  State<CurrentPlayerIndex> createState() => _CurrentPlayerIndexState();
}

class _CurrentPlayerIndexState extends State<CurrentPlayerIndex> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          height: 130,
          width: 95,
          duration: Duration(milliseconds: 300),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorsPalette.a,
            border: Border.all(
                color: widget.currentPlayerNum == widget.plrNumber
                    ? Colors.white
                    : Colors.transparent,
                width: widget.currentPlayerNum == widget.plrNumber ? 2 : 0),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                widget.plrData.AvatarPath,
                height: 50,
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                widget.plrData.Name,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  // height: ,
                  color: Colors.white,
                ),
              ),
              Text(
                "Player ${widget.plrNumber}",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  height: 1,
                  color: Colors.white.withOpacity(.5),
                ),
              )
            ],
          ),
        ),
        AnimatedScale(
          key: GlobalKey(),
          scale: widget.currentPlayerNum == widget.plrNumber ? 1 : 0,
          duration: Duration(microseconds: 200),
          curve: Curves.linear,
          alignment: widget.currentPlayerNum == 1
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: SvgPicture.asset(
            'assets/icons/current_player_index.svg',
            height: 20,
          ),
        ),
      ],
    );
  }
}

class PlayBoard3x3 extends StatelessWidget {
  PlayBoard3x3({
    super.key,
    required this.OnPlay,
    required this.currentPlayer,
    required this.p1Positions,
    required this.p2Positions,
    required this.avatar1,
    required this.avatar2,
    this.winCells,
    this.blockInsert = false,
  });
  final Function(int position) OnPlay;
  final int currentPlayer;
  final List<int> p1Positions;
  final List<int> p2Positions;
  final String avatar1;
  final String avatar2;
  final List<int>? winCells;
  final bool blockInsert;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final demension = width - 40;
    final double padding = 15;
    final double spacing = 10;
    final radius =
        ((demension - (2 * padding) - (spacing * 2)) / 3 / 2) + padding;
    return SizedBox.square(
      dimension: width - 50,
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
        color: Colors.white.withOpacity(.9),
        margin: EdgeInsets.zero,
        child: GridView.builder(
          padding: EdgeInsets.all(padding),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: spacing,
            mainAxisSpacing: spacing,
          ),
          itemCount: 9,
          itemBuilder: (_, i) {
            return GestureDetector(
              onTap: blockInsert
                  ? null
                  : () {
                      if (!p1Positions.contains(i) && !p2Positions.contains(i))
                        OnPlay(i);
                    },
              child: CircleAvatar(
                backgroundColor: _getCellColor(i),
                minRadius: demension / 3,
                child: Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 50),
                    child: p1Positions.contains(i)
                        ? _getAvatarImg(avatar1)
                        : p2Positions.contains(i)
                            ? _getAvatarImg(avatar2)
                            : _getEmptyAvatar(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getCellColor(int i) {
    // if (blockInsert)return Colors.grey.withOpacity(.5);
    if (winCells != null && winCells!.contains(i)) return Colors.green[400]!;
    return p1Positions.contains(i)
        ? Colors.orangeAccent.withOpacity(.5)
        : p2Positions.contains(i)
            ? Colors.blueAccent.withOpacity(.5)
            : blockInsert
                ? Colors.grey.withOpacity(.5)
                : ColorsPalette.b.withOpacity(.5);
  }

  Widget _getAvatarImg(String path) => AnimatedScale(
        scale: 1,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOutBack,
        child: Image(
          image: AssetImage(path),
          height: 50,
        ),
      );
  Widget _getEmptyAvatar() => AnimatedScale(
        scale: 0,
        duration: Duration(milliseconds: 200),
        child: SizedBox.square(dimension: 50),
      );
}
