import 'package:flutter/material.dart';

class ResuableText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const ResuableText({super.key, required this.text, required this.style});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: 1,
        overflow: TextOverflow.fade,
        softWrap: false,
        style: style);
  }
}
