import 'package:flutter/material.dart';

class TitleInfo extends StatelessWidget {
  const TitleInfo({super.key,required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return     Container(
              decoration:
                  BoxDecoration(color: Color.fromARGB(255, 238, 237, 239)),
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
              margin: EdgeInsets.symmetric(vertical: 10),
              child:  Text(
                title,
                style:Theme.of(context).textTheme.titleLarge,
              ),
            );
        
  }
}