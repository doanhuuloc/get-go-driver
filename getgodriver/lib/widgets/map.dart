import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:uuid/uuid.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

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
  late Location _location;
  // LocationData? _currentLocation;
  double _heading = 0.0;

  Map<String, Marker> _marker = {};

  // hàm lấy vị trí hiện tại
  _init() async {
    _location = Location();
    _initLocation();
  }

  _initLocation() {
    _location.getLocation().then((location) {
      widget.currentLocation.coordinates =
          LatLng(location.latitude ?? 0, location.longitude ?? 0);
      // context.read<SocketService>().driverSendToServer(
      //     widget.currentLocation.coordinates, location.heading ?? 0);
      // _currentLocation = location;
    });
    _location.onLocationChanged.listen((newLocation) async {
      double result = await Geolocator.distanceBetween(
        widget.currentLocation.coordinates.latitude,
        widget.currentLocation.coordinates.longitude,
        newLocation.latitude!,
        newLocation.longitude!,
      );
      // cứ đi được 100 mét là set lại vị trí
      if (result > 200) {
        // _currentLocation = newLocation;
        widget.currentLocation.coordinates =
            LatLng(newLocation.latitude ?? 0, newLocation.longitude ?? 0);
        // gửi vị trí về server
        // context.read<SocketService>().driverUpdateServer(
        //     widget.currentLocation.coordinates, newLocation.heading ?? 0);
        _moveCameraToLocation(
            LatLng(newLocation.latitude ?? 0, newLocation.longitude ?? 0));
        addMarkerSVG('current', widget.currentLocation.coordinates, widget.icon,
            newLocation.heading ?? 0);
      }
    });
  }

  // hàm duy chuyển camera tới vị trí LatLng
  void _moveCameraToLocation(LatLng location) async {
    GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 15)));
  }

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    // Khởi tạo vị trí
    _init();
  }

  Future<void> _loadMapStyle() async {
    String style = await rootBundle.loadString('assets/jsons/map_style.json');
    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
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
      myLocationEnabled: false,
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
    addMarkerSVG('current', widget.currentLocation.coordinates, widget.icon, 0);
    for (LatLng point in widget.listDrive) {
      addMarkerSVG(const Uuid().v4(), point, 'assets/svgs/CarMap.svg',
          Random().nextDouble() * 360 + 1);
    }
    if (widget.desLocation != null) addPolylineAndFitMap();
  }

  Future<void> addPolylineAndFitMap() async {
    addMarkerSVG('marker', widget.desLocation!.coordinates,
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

  Future<void> addMarkerSVG(
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
