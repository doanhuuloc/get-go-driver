import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChangeDate extends StatelessWidget {
  const ChangeDate({
    super.key,
    required this.dateTime,
    required this.backDate,
    required this.forwardDate,
  });
  final DateTime dateTime;
  final VoidCallback backDate;
  final VoidCallback forwardDate;
  @override
  Widget build(BuildContext context) {
    final format = DateFormat("dd/MM/yyyy");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: format.format(dateTime) == format.format(DateTime.now())
              ? null
              : backDate,
          icon: const Icon(Icons.arrow_back_ios),
          disabledColor: Colors.grey,
        ),
        Text(format.format(dateTime)),
        IconButton(
          onPressed: forwardDate,
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
