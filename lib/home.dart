import 'package:flutter/material.dart';
import 'package:tic_tac_toe/colors.dart';
import 'package:tic_tac_toe/enter_player_name.dart';
import 'package:tic_tac_toe/widgets/button.dart';
import 'package:tic_tac_toe/widgets/scaf_bacround.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScafBackround(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              SvgPicture.asset(
                'assets/images/tic_tac_toe.svg',
                height: MediaQuery.of(context).size.height * .5,
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Button(
                      text: 'Play With Friend',
                      startColor: ColorsPalette.c,
                      endColor: ColorsPalette.d,
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return EnterPlayerName();
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Button(
                      text: 'Play With Phone',
                      startColor: ColorsPalette.f,
                      endColor: ColorsPalette.e,
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return EnterPlayerName();
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Button(
                      text: 'Play History',
                      startColor: ColorsPalette.r,
                      endColor: ColorsPalette.t,
                      onClick: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return EnterPlayerName();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              )
               
            ],
          ),
        ),
      ),
    );
  }
}
