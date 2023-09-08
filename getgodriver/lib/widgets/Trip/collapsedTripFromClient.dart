import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/services/googlemap/openGoogleMaps.dart';
import 'package:getgodriver/widgets/Trip/buttonChangeStatusTrip.dart';
import 'package:getgodriver/widgets/address.dart';
import 'package:getgodriver/widgets/customerInfo.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routes/routes.dart';

class CollapsedTripFromClient extends StatelessWidget {
  const CollapsedTripFromClient({super.key});

  @override
  Widget build(BuildContext context) {
    final TripViewModel trip = context.read<TripViewModel>();

    final theme = Theme.of(context);
    return Container(
      height: 500,
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.primaryColor,
          width: 2,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        //  BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 5),
          padding: const EdgeInsets.symmetric(horizontal: 175),
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
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomerInfo(
                    avatar: trip.avatar,
                    name: trip.name,
                    phone: trip.phone,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.message);
                    },
                    iconSize: 30,
                    icon: Icon(
                      Icons.chat,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.phone,
                        color: Theme.of(context).primaryColor,
                      ))
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: 1,
                decoration: const BoxDecoration(color: Colors.black38),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Address(
                    address: trip.toAddress.summary,
                    img: "assets/svgs/toaddress.svg",
                  )),
                  InkWell(
                    onTap: () {
                      OpenGoogleMaps.openGoogleMaps(context
                          .read<TripViewModel>()
                          .fromAddress
                          .coordinates);
                    },
                    child: SvgPicture.asset(
                      'assets/svgs/mapArrow.svg',
                      // width: 13,
                      // height: 17.64,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const ButtonChangeStatusTrip(),
            ],
          ),
        )
      ]),
    );
  }
}
