import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tic_tac_toe/constants/avatars.dart';
import 'package:tic_tac_toe/constants/colors.dart';
import 'package:tic_tac_toe/widgets/button.dart';
import 'package:tic_tac_toe/widgets/scaf_bacround.dart';

enum PlayType {
  PlayerVsBot,
  PlayerVsPlayer,
}

class EnterPlayerName extends StatefulWidget {
  const EnterPlayerName({super.key, required this.playType});

  final PlayType playType;

  @override
  State<EnterPlayerName> createState() => _EnterPlayerNameState();
}

class _EnterPlayerNameState extends State<EnterPlayerName> {
  _getPlayerAvatar() {
    var a = AvatarsPalette.playerAvatars.elementAt(
        Random.secure().nextInt(AvatarsPalette.playerAvatars.length - 1));
    if (a == _playerOneAvatar) {
      a = _getPlayerAvatar();
    }
    print(a);
    return a;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _playerOneAvatar = _getPlayerAvatar();
    _playerTwoAvatar = _getPlayerAvatar();
  }

  String? _playerOneAvatar;
  String? _playerTwoAvatar;

  BotDifficulty _botPlayerDifficulty = BotDifficulty.Easy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 75,
        leadingWidth: 80,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            'assets/icons/ic_fluent_arrow_circle_left_24_filled.svg',
            color: Colors.white,
            height: 30,
            alignment: Alignment.centerRight,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ScafBackround(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // SizedBox(
              //   height: 10,
              // ),
              SvgPicture.asset(
                'assets/images/tic_tac_toe.svg',
                height: 120,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Play with Bot',
                style: TextStyle(
                  color: Colors.white.withOpacity(.8),
                  fontSize: 10,
                  // height: 1.5,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Poppins',
                ),
              ),
              Title(
                title: 'Enter Your  Name',
              ),
              SizedBox(
                height: 15,
              ),
              TextInput(
                title: '1. Player One',
                playerAvatarPath: _playerOneAvatar!,
                controller: TextEditingController(),
              ),
              SizedBox(
                height: 5,
              ),
              if (widget.playType == PlayType.PlayerVsPlayer)
                TextInput(
                  title: '2. Player Two',
                  playerAvatarPath: _playerTwoAvatar!,
                  controller: TextEditingController(),
                )
              else
                BotPlayerSelectDifficulty(
                  selectedIndex: _botPlayerDifficulty.index,
                  onChangeLevel: (level) {
                    _botPlayerDifficulty = level;
                  },
                ),
              Spacer(),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: 200,
                  child: Button(
                    text: 'Play',
                    onClick: () {},
                    startColor: ColorsPalette.r,
                    endColor: ColorsPalette.t,
                    iconPath:
                        'assets/icons/ic_fluent_arrow_right_24_filled.svg',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 25,
            height: 1.2,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          height: 5,
          width: MediaQuery.of(context).size.width * .1,
          color: Colors.yellow,
        )
      ],
    );
  }
}

class TextInput extends StatelessWidget {
  const TextInput(
      {super.key,
      required this.title,
      required this.playerAvatarPath,
      required this.controller});
  final String title;
  final String playerAvatarPath;
  final TextEditingController controller;
  final double _fieldHeight = 60;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 17,
            color: Colors.white.withOpacity(.9),
            fontWeight: FontWeight.normal,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(
          height: 6,
        ),
        SizedBox(
          height: _fieldHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.5),
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
              Positioned(
                width: _fieldHeight,
                height: _fieldHeight,
                // top: 0,
                left: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      playerAvatarPath,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: _fieldHeight + 15,
                right: 10,
                height: _fieldHeight,
                child: Center(
                  child: TextField(
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.white.withOpacity(.9),
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Poppins',
                    ),
                    decoration: InputDecoration(
                      hintText: 'Player Name',
                      hintStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white.withOpacity(.6),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                      isCollapsed: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BotPlayerSelectDifficulty extends StatefulWidget {
  const BotPlayerSelectDifficulty(
      {super.key, required this.selectedIndex, required this.onChangeLevel});
  final int selectedIndex;
  final Function(BotDifficulty level) onChangeLevel;

  @override
  State<BotPlayerSelectDifficulty> createState() =>
      _BotPlayerSelectDifficultyState();
}

class _BotPlayerSelectDifficultyState extends State<BotPlayerSelectDifficulty> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '2. Play Difficulty',
          style: TextStyle(
            fontSize: 17,
            color: Colors.white.withOpacity(.9),
            fontWeight: FontWeight.normal,
            fontFamily: 'Poppins',
          ),
        ),
        SizedBox(
          height: 5,
        ),
        BotDifficultyRow(
          onTap: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
          isSelected: _selectedIndex == 0,
          type: BotDifficulty.Easy,
        ),
        SizedBox(
          height: 10,
        ),
        BotDifficultyRow(
          onTap: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
          isSelected: _selectedIndex == 1,
          type: BotDifficulty.Medium,
        ),
        SizedBox(
          height: 10,
        ),
        BotDifficultyRow(
          onTap: () {
            setState(() {
              _selectedIndex = 2;
            });
          },
          isSelected: _selectedIndex == 2,
          type: BotDifficulty.Difficult,
        ),
      ],
    );
  }
}

class BotDifficultyRow extends StatelessWidget {
  const BotDifficultyRow(
      {super.key,
      required this.type,
      required this.isSelected,
      required this.onTap});
  final BotDifficulty type;
  final bool isSelected;
  final Function() onTap;

  final double _fieldHeight = 60;

  String _getDifficultyPath() {
    switch (type) {
      case BotDifficulty.Easy:
        return 'assets/icons/easy_bot.png';
      case BotDifficulty.Medium:
        return 'assets/icons/medium_bot.png';
      case BotDifficulty.Difficult:
        return 'assets/icons/difficult_bot.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: _fieldHeight,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white.withOpacity(.5),
                ),
              ),
            ),
            Positioned.fill(
              child: Center(
                child: Text(
                  type.name + " Bot",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(.9),
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            if (isSelected)
              Positioned(
                right: 20,
                height: _fieldHeight,
                child: SvgPicture.asset(
                  'assets/icons/ic_fluent_checkmark_24_filled.svg',
                  color: Colors.white,
                ),
              ),
            Positioned(
              left: 0,
              height: _fieldHeight,
              width: _fieldHeight,
              child: Image.asset(
                _getDifficultyPath(),
                fit: BoxFit.scaleDown,
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum BotDifficulty {
  Easy,
  Medium,
  Difficult,
}
