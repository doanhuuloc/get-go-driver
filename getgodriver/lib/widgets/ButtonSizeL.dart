import 'package:flutter/material.dart';

class ButtonSizeL extends StatelessWidget {
  final String name;
  final Function onTap;
  double height;
  ButtonSizeL(
      {required this.onTap, required this.name, this.height = 50, super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onTap();
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: 378,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
