import 'dart:ffi';

import 'package:flutter/material.dart';

class LineHistory extends StatelessWidget {
  const LineHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("18:00 27/07/2023")),
              Row(
                children: [
                  Text("200000đ"),
                  const SizedBox(width: 10),
                  Icon(Icons.arrow_forward_ios),
                  const SizedBox(width: 10),
                ],
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            height: 1,
            decoration: BoxDecoration(color: Colors.black12),
          )
        ],
      ),
    );
  }
}
