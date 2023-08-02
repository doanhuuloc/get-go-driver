import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getgodriver/models/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:uuid/uuid.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  LocationModel currentLocation;
  LocationModel? desLocation;
  List<PointLatLng> listPoint;
  List<LatLng> listDrive;
  String icon;
  MapScreen(
      {required this.currentLocation,
      required this.icon,
      this.desLocation,
      this.listPoint = const [],
      this.listDrive = const [],
      Key? key})
      : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Map<String, Marker> _marker = {};
  Future<void> _getCurrentLocation() async {
    try {
      while (true) {
        await Permission.location.request();
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        print('ydddđfffffffff');
        print(position.accuracy);
        LatLng location = LatLng(position.latitude, position.longitude);
        if (widget.currentLocation.coordinates != location) {
          widget.currentLocation.coordinates = location;
          print(11111111111);
          addMarker('current', widget.currentLocation.coordinates, widget.icon,
              position.accuracy);
          final GoogleMapController controller = await _controller.future;

          _moveCameraToLocation(widget.currentLocation.coordinates);
          print(location.latitude);
          print(location.longitude);
        }

        // setState(() {});
        await Future.delayed(Duration(seconds: 10));
      }
    } catch (e) {
      throw Exception('Request failed with status: $e}');
    }
  }

  void _moveCameraToLocation(LatLng location) async {
    final GoogleMapController controller = await _controller.future;
    controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: location,
          zoom: 16,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    _getCurrentLocation();
  }

  Future<void> _loadMapStyle() async {
    String style = await rootBundle.loadString('assets/jsons/map_style.json');
    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle(style);
  }

  Future<void> _goToLatlng(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      // bearing: 192.8334901395799,
      target: position,
      // tilt: 59.440717697143555,
      zoom: 16,
    )));
  }

  @override
  Widget build(BuildContext context) {
    // Thêm dòng sau để lấy tọa độ từ polylinePoints của bạn

    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: widget.currentLocation.coordinates,
        zoom: 16,
      ),
      onMapCreated: onCreated,
      markers: _marker.values.toSet(),
      compassEnabled: false,
      zoomControlsEnabled: false,
      myLocationEnabled: true,
      myLocationButtonEnabled: widget.desLocation != null ? true : false,
      polylines: {
        if (widget.listPoint.isNotEmpty)
          Polyline(
            polylineId: const PolylineId('overview_polyline'),
            color: Theme.of(context).primaryColor,
            width: 4,
            points: widget.listPoint.map((e) {
              return LatLng(e.latitude, e.longitude);
            }).toList(),
          ),
      },
    );
  }

  void onCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    addMarker('current', widget.currentLocation.coordinates, widget.icon, 0);
    print('aaaaaaaaaaaaaaaaaaaaaa');
    for (LatLng point in widget.listDrive) {
      addMarker(const Uuid().v4(), point, 'assets/svgs/CarMap.svg',
          Random().nextDouble() * 360 + 1);
    }
    if (widget.desLocation != null) addPolylineAndFitMap();
    // else {
    //   print('dd')
    //   addMarkerPicture(
    //       'current', widget.currentLocation, 'assets/svgs/manhtu.png');
    // }
  }

  Future<void> addPolylineAndFitMap() async {
    addMarker('marker', widget.desLocation!.coordinates!,
        'assets/svgs/DesDetail.svg', 0);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      List<LatLng> points = widget.listPoint.map((e) {
        return LatLng(e.latitude, e.longitude);
      }).toList();
      await Future.delayed(Duration(milliseconds: 500));
      await _setMapFitToTour(points);
    });
  }

  Future<void> _setMapFitToTour(List<LatLng> points) async {
    if (points.isEmpty) return;

    final GoogleMapController controller = await _controller.future;

    double minLat =
        points.reduce((a, b) => a.latitude < b.latitude ? a : b).latitude;
    double maxLat =
        points.reduce((a, b) => a.latitude > b.latitude ? a : b).latitude;
    double minLng =
        points.reduce((a, b) => a.longitude < b.longitude ? a : b).longitude;
    double maxLng =
        points.reduce((a, b) => a.longitude > b.longitude ? a : b).longitude;

    controller.animateCamera(CameraUpdate.newLatLngBounds(
      LatLngBounds(
        southwest: LatLng(minLat, minLng),
        northeast: LatLng(maxLat, maxLng),
      ),
      60,
    ));
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromSvgAsset(
    String assetName, [
    Size size = const Size(48, 48),
  ]) async {
    final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetName), null);

    double devicePixelRatio = ui.window.devicePixelRatio;
    int width = (size.width * devicePixelRatio).toInt();
    int height = (size.height * devicePixelRatio).toInt();

    final scaleFactor = math.min(
      width / pictureInfo.size.width,
      height / pictureInfo.size.height,
    );

    final recorder = ui.PictureRecorder();

    ui.Canvas(recorder)
      ..scale(scaleFactor)
      ..drawPicture(pictureInfo.picture);

    final rasterPicture = recorder.endRecording();

    final image = rasterPicture.toImageSync(width, height);
    final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!;

    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }

  Future<void> addMarkerPicture(
      String id, LatLng location, String assetName, double rotate) async {
    // BitmapDescriptor.fromAssetImage(configuration, assetName)
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(200, 200)),
      assetName,
    ).then((icon) {
      var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: const InfoWindow(
          title: 'End Point',
          snippet: 'End Marker',
        ),
        icon: icon,
        rotation: rotate,
      );
      _marker[id] = marker;
      setState(() {});
    });
  }

  Future<void> addMarker(
      String id, LatLng location, String assetName, double rotate) async {
    BitmapDescriptor svgIcon =
        await getBitmapDescriptorFromSvgAsset(assetName, const Size(40, 40));
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
      infoWindow: const InfoWindow(
        title: 'End Point',
        snippet: 'End Marker',
      ),
      icon: svgIcon,
      rotation: rotate,
    );
    _marker[id] = marker;
    setState(() {});
  }
}
