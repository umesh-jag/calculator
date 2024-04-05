import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Mybutton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTapped;
  const Mybutton(
      {super.key,
      required this.buttonText,
      required this.color,
      required this.textColor,
      required this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipOval(
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
