import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SlideButton extends StatelessWidget {
  final Function onSubmit;
  String text;
  SlideButton({super.key, required this.onSubmit, required this.text});

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      borderRadius: 10,
      height: 55,
      sliderButtonIconPadding: 10,
      innerColor: Colors.white,
      outerColor: Theme.of(context).primaryColor,
      text: text,
      onSubmit: () {
        onSubmit();
      },
      //  sliderButtonIcon: null,
    );
  }
}
