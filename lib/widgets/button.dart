import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.text,
      this.icon,
      required this.onClick,
      required this.startColor,
      required this.endColor});
  final String text;
  final IconData? icon;
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
              if (icon != null) ...[
                SizedBox(
                  width: 5,
                ),
                Icon(icon, color: Colors.indigo),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
