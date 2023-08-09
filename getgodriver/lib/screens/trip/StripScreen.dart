import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/provider/location_view_model.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/trip.dart';
import 'package:getgodriver/widgets/Buider/GoogleMapBuider.dart';
import 'package:getgodriver/widgets/ButtonSizeL.dart';
import 'package:getgodriver/widgets/IconText.dart';
import 'package:getgodriver/widgets/Trip/Arrived.dart';
import 'package:getgodriver/widgets/slideButton.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:url_launcher/url_launcher.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({super.key});

  @override
  State<TripScreen> createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  late LocationModel _currentLocation;
  late SocketService socketProvider;
  bool checkArrived = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    socketProvider = context.read<SocketService>();
  }

  void openGoogleMaps() async {
    String destinationLatitude = "10.7625";
    String destinationLongitude = "106.6823";
    String mapUrl = "geo:$destinationLatitude,$destinationLongitude";
    //  final String googleMapslocationUrl = "https://www.google.com/maps/search/?api=1&query=${TextStrings.homeLat},${TextStrings.homeLng}";

    if (await canLaunch(mapUrl)) {
      await launch(mapUrl);
    } else {
      throw "Không thể mở Google Maps.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
            // height: MediaQuery.of(context).size.height -
            //     MediaQuery.of(context).size.height / 2.6,
            child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 200,
              child: GoogleMapBuider(
                      currentLocation: LocationModel(title: '', summary: ''))
                  .build(),
            ),
            Positioned(
              // top: MediaQuery.of(context).size.height / 2,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(16),
                // height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 160),
                      child: Container(
                        height: 6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              5), // Điều chỉnh giá trị để thay đổi độ cong của Divider
                          color: Color(0xFFACAAAA),
                        ),
                      ),
                    ),
                    Selector<TripViewModel, String>(
                        selector: (context, setting) => setting.status,
                        builder: (context, status, child) {
                          return status == 'Confirmed'
                              ? Arrived()
                              : const Text('');
                        }),

                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/CurrentDetail.svg',
                          // width: 13,
                          // height: 17.64,
                        ),
                        const SizedBox(width: 16),
                        const Expanded(
                          child: Text(
                            '77/50/8 Đường Chuyên dùng 9 Phường Phú Mỹ Quận 7 TPHCM',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff3e4958),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: openGoogleMaps,
                          child: SvgPicture.asset(
                            'assets/svgs/mapArrow.svg',
                            // width: 13,
                            // height: 17.64,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/note.svg',
                          // width: 13,
                          // height: 17.64,
                        ),
                        const SizedBox(width: 16),
                        Selector<TripViewModel, String>(
                            selector: (context, setting) => setting.status,
                            builder: (context, status, child) {
                              return status == 'Confirmed'
                                  ? const Expanded(
                                      child: Text(
                                        'Chuk Chuk',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff3e4958),
                                        ),
                                      ),
                                    )
                                  : const Text('');
                            }),

                        // SvgPicture.asset(
                        //   'assets/svgs/edit.svg',
                        //   // width: 13,
                        //   // height: 17.64,
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Selector<TripViewModel, String>(
                        selector: (context, setting) => setting.status,
                        builder: (context, status, child) {
                          return status == 'Confirmed'
                              ? ButtonSizeL(
                                  name: "Đã đến điểm đón",
                                  onTap: () {
                                    context
                                        .read<TripViewModel>()
                                        .updateStatus('pickUp');
                                  })
                              : SizedBox();
                        }),
                    Selector<TripViewModel, String>(
                        selector: (context, setting) => setting.status,
                        builder: (context, status, child) {
                          return status == 'pickUp'
                              ? SlideAction(
                                  borderRadius: 10,
                                  height: 55,
                                  sliderButtonIconPadding: 10,
                                  innerColor: Colors.white,
                                  outerColor: Theme.of(context).primaryColor,
                                  text: 'Bắt đầu chuyến đi',
                                  onSubmit: () {
                                    socketProvider.handleTripUpdate(
                                        context, 'Driving');
                                  },
                                  //  sliderButtonIcon: null,
                                )
                              : SizedBox();
                        }),
                    Selector<TripViewModel, String>(
                        selector: (context, setting) => setting.status,
                        builder: (context, status, child) {
                          return status == 'Driving'
                              ? SlideAction(
                                  borderRadius: 10,
                                  height: 55,
                                  sliderButtonIconPadding: 10,
                                  innerColor: Colors.white,
                                  outerColor: Theme.of(context).primaryColor,
                                  text: 'Kết thúc chuyến đi',
                                  onSubmit: () {
                                    print('hee');
                                    socketProvider.handleTripUpdate(
                                        context, 'Arrived');
                                  },
                                  //  sliderButtonIcon: null,
                                )
                              : SizedBox();
                        }),
                    // PlaceStrip(),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
