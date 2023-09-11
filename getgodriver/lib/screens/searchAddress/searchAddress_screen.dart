import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/routes/routes.dart';
import 'package:getgodriver/services/api/api_trip.dart';
import 'package:getgodriver/services/googlemap/api_places.dart';
import 'package:getgodriver/widgets/searchAddress/locationListTitle.dart';
import 'package:getgodriver/widgets/textInputField.dart';
import 'package:provider/provider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class SearchAddressScreen extends StatefulWidget {
  const SearchAddressScreen({super.key});

  @override
  State<SearchAddressScreen> createState() => _SearchAddressScreenState();
}

class _SearchAddressScreenState extends State<SearchAddressScreen> {
  final TextEditingController _inputAddress = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<LocationModel> locations = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inputAddress.addListener(() {
      onChange(_inputAddress.text);
    });
  }

  void onChange(String text) async {
    if (text.length > 2) {
      Timer(Duration(seconds: 1), () async {
        locations = await APIPlace.getSuccession(text);
      });
    } else
      locations = [];
    setState(() {});
  }

  void onLocationListTitleTap(LocationModel location) async {
    _inputAddress.text = location.summary;
    final trip = context.read<TripViewModel>();
    final driver = context.read<DriverViewModel>();
    await trip.updateLocation(location);
    Map<String, dynamic> detail = await APIPlace.getDirectionAndDistance(
        origin: driver.myLocation.coordinates,
        destination: location.coordinates);
    trip.updateDirection(
        PolylinePoints().decodePolyline(detail['polylinePoints']));
    detail['price'] = trip.updateTrip(detail['distance']);
    await ApiTrip.updateTripCallcenter(
        detail, driver.accessToken, trip.id.toString(), location);
    // Navigator.of(context).pushNamed(Routes.tripDriving);
    Navigator.of(context).pushReplacementNamed(Routes.tripDriving);
    // Navi ở đây
    locations = [];
    // vẽ đường đi, duration, distance, end, price
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Nhập điểm đến"),
        backgroundColor: theme.primaryColor,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextInputField(
              focus: _focusNode,
              controller: _inputAddress,
              hintText: "Nhập địa chỉ đến",
            ),
            const SizedBox(height: 10),
            const Divider(
              height: 1,
              color: Colors.black26,
            ),
            const SizedBox(height: 10),
            LocationListTitle(
              locations: locations,
              onClick: onLocationListTitleTap,
            ),
          ],
        ),
      ),
    ));
  }
}
