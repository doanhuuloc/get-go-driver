import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class LineInfo extends StatelessWidget {
  const LineInfo({super.key,required this.title,required this.content,required this.img,this.colors});
  final String title;
  final String content;
  final String img;
  final Color? colors;
  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                img,
                width: 30,
                height: 30,
                // ignore: deprecated_member_use
                color: colors,
              ),
              const SizedBox(width: 10),
              Text(title, style: TextStyle(fontSize: 18)),
            ],
          ),
          Text(content,
              style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
