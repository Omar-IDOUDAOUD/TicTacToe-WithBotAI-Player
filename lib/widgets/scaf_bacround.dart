import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tic_tac_toe/colors.dart';

class ScafBackround extends StatefulWidget {
  const ScafBackround({super.key, required this.child});
  final Widget child;

  @override
  State<ScafBackround> createState() => _ScafBackroundState();
}

class _ScafBackroundState extends State<ScafBackround> {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorsPalette.a,
            ColorsPalette.b,
          ],
          end: Alignment.topCenter,
          begin: Alignment.bottomCenter,
        ),
      ),
      child: SizedBox.expand(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/backround_effect.svg',
              fit: BoxFit.fitHeight,
            ),
            Positioned.fill(
              child: widget.child,
            )
          ],
        ),
      ),
    );
  }
}
