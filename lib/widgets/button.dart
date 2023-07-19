import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.text,
      this.iconPath,
      required this.onClick,
      required this.startColor,
      required this.endColor});
  final String text;
  final String? iconPath;
  final Function() onClick;
  final Color startColor;
  final Color endColor;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: MaterialButton(
        onPressed: onClick,
        padding: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        splashColor: Colors.black.withOpacity(.2),
        elevation: 20,
        focusElevation: 10,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Postnobillscolombo'),
              ),
              if (iconPath != null) ...[
                Spacer(),
                SvgPicture.asset(iconPath!, color: Colors.white),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
