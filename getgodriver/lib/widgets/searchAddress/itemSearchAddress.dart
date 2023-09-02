import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ItemSearchAddress extends StatelessWidget {
  const ItemSearchAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.17,
              child: SvgPicture.asset(
                "assets/svgs/toaddress.svg",
                height: 30,
                width: 30,
              )),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Khoa Học Tự Nhiên",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  "227 nguyễn văn cừ, phường 4, quận 5, thành phố Hồ Chí Minh",
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                const Divider(
                  height: 1,
                  color: Colors.black38,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
