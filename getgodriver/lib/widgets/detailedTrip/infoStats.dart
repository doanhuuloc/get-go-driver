import 'package:flutter/material.dart';

class InfoStats extends StatelessWidget {
  const InfoStats({
    super.key,
    required this.title,
    required this.content,
    this.color,
  });

  final String title;
  final String content;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        SizedBox(height: 5),
        Text(content, style: TextStyle(color: color)),
      ],
    );
  }
}
