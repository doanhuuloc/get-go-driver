import 'package:flutter/material.dart';


class StatsDriver extends StatelessWidget {
  const StatsDriver({
    super.key,
    required this.title,
    required this.stats,
    required this.isStarRate,
  });
  final String title;
  final String stats;
  final bool isStarRate;
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Column(
      children: [
        Text(title),
        Row(
          children: [
            Text(stats),
            const SizedBox(height: 25),
            if (isStarRate)
              Icon(
                Icons.star,
                color: themeData.primaryColor,
              )
          ],
        ),
      ],
    );
  }
}