import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:getgodriver/widgets/IconText.dart';

class Arrived extends StatelessWidget {
  const Arrived({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    'Nguyễn Đăng Mạnh Tú',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff3e4958),
                    ),
                  ),
                  // SizedBox(height: 6),
                  IconText(icon: 'Star', text: "4.8"),
                ],
              ),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Theme.of(context).primaryColor),
              child: Icon(
                Icons.message,
                size: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  color: Theme.of(context).primaryColor),
              child: Icon(
                Icons.call,
                size: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        const Divider(
          thickness: 1,
          height: 8,
          color: Color(0xFFD5DDE0),
        ),
      ],
    );
  }
}
