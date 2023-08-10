import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CollapsedTrip extends StatelessWidget {
  const CollapsedTrip({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 5),
          padding: EdgeInsets.symmetric(horizontal: 175),
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  5), // Điều chỉnh giá trị để thay đổi độ cong của Divider
              color: Color(0xFFACAAAA),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgPicture.asset(
                'assets/svgs/Car.svg',
                width: 40,
                height: 40,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Text(
                        "Đón khách",
                        style: TextStyle(color: theme.primaryColor),
                      ),
                      Text(
                        "77/50/8 Đường Chuyên dùng 9 Phường Phú Mỹ Quận 7 TPHCM",
                        style: TextStyle(overflow: TextOverflow.clip),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: SvgPicture.asset(
                  'assets/svgs/mapArrow.svg',
                  // width: 13,
                  // height: 17.64,
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
