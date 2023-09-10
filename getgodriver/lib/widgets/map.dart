import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getgodriver/models/location.dart';
import 'package:getgodriver/provider/driverViewModel.dart';
import 'package:getgodriver/provider/sockets/ServiceSocket.dart';
import 'package:getgodriver/provider/tripViewModel.dart';
import 'package:getgodriver/services/googlemap/api_places.dart';
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
      print('heee');
      double result = 0;
      result = Geolocator.distanceBetween(
        widget.currentLocation.coordinates.latitude,
        widget.currentLocation.coordinates.longitude,
        location.latitude!,
        location.longitude!,
      );
      if (result > 50) {
        widget.currentLocation.coordinates =
            LatLng(location.latitude ?? 0, location.longitude ?? 0);
        context.read<DriverViewModel>().updateMyLocation(
            LatLng(location.latitude ?? 0, location.longitude ?? 0),
            location.heading ?? 0);

        addMarkerPicture('current', widget.currentLocation.coordinates,
            widget.icon, location.heading ?? 0);
        if (context.read<TripViewModel>().direction.isEmpty) {
          _moveCameraToLocation(
              LatLng(location.latitude ?? 0, location.longitude ?? 0));
        }
      }

      // context.read<SocketService>().driverSendToServer(
      //     widget.currentLocation.coordinates, location.heading ?? 0);
      // _currentLocation = location;
    });
    _location.onLocationChanged.listen((newLocation) async {
      if (mounted) {
        final provider = context.read<DriverViewModel>();
        double result = 0;
        result = Geolocator.distanceBetween(
          widget.currentLocation.coordinates.latitude,
          widget.currentLocation.coordinates.longitude,
          newLocation.latitude!,
          newLocation.longitude!,
        );
        // if (newLocation.heading != widget.currentLocation.heading)
        //   addMarkerSVG('current', widget.currentLocation.coordinates, widget.icon,
        //       newLocation.heading ?? 0);
        // print("cout<< $result");
        // cứ đi được 100 mét là set lại vị trí
        if (result > 200) {
          provider.updateMyLocation(
              LatLng(newLocation.latitude ?? 0, newLocation.longitude ?? 0),
              newLocation.heading ?? 0);
          widget.currentLocation.coordinates =
              LatLng(newLocation.latitude ?? 0, newLocation.longitude ?? 0);

          if (provider.status != "offline") {
            SocketService.driverUpdateServer(
                LatLng(newLocation.latitude ?? 0, newLocation.longitude ?? 0),
                newLocation.heading ?? 0,
                '');
          }
          if (context.read<TripViewModel>().direction.isNotEmpty) {
            print('cout<<ne ${widget.desLocation!.coordinates}');
            print(
                'cout<<ne ${LatLng(newLocation.latitude ?? 0, newLocation.longitude ?? 0)}');
            String directions = await APIPlace.getDirections(
                origin: LatLng(
                    newLocation.latitude ?? 0, newLocation.longitude ?? 0),
                destination: widget.desLocation!.coordinates);
            if (directions != '[]') directions = '';
            SocketService.driverUpdateServer(
                LatLng(newLocation.latitude ?? 0, newLocation.longitude ?? 0),
                newLocation.heading ?? 0,
                directions);
            widget.listPoint = PolylinePoints().decodePolyline(directions);
            setState(() {});
          } else {
            _moveCameraToLocation(
                LatLng(newLocation.latitude ?? 0, newLocation.longitude ?? 0));
          }
          addMarkerPicture('current', widget.currentLocation.coordinates,
              widget.icon, newLocation.heading ?? 0);
        }
      }
    });
  }

  // hàm duy chuyển camera tới vị trí LatLng
  void _moveCameraToLocation(LatLng location) async {
    GoogleMapController mapController = await _controller.future;
    mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 16.5)));
  }

  @override
  void initState() {
    print('fdsfsadfsdfs1111111111111111111111111111111');
    super.initState();
    _loadMapStyle();
    // Khởi tạo vị trí
    _init();
  }

  @override
  void dispose() {
    _controller.future.then((GoogleMapController controller) {
      controller.dispose();
    });
    super.dispose();
  }

  Future<void> _loadMapStyle() async {
    String style = await rootBundle.loadString('assets/jsons/map_style.json');
    final GoogleMapController controller = await _controller.future;
    controller.setMapStyle(style);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
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
        ),
        Positioned(
          bottom: 15.0,
          right: 16.0,
          child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              if (widget.desLocation != null) {
                List<LatLng> points = widget.listPoint.map((e) {
                  return LatLng(e.latitude, e.longitude);
                }).toList();
                _setMapFitToTour(points);
              } else {
                _moveCameraToLocation(widget.currentLocation.coordinates);
              }
            },
            child: Icon(Icons.my_location),
            // style: ElevatedButton.styleFrom(
            //   backgroundColor: Theme.of(context).primaryColor,
            //   padding: EdgeInsets.all(0), // Điều này sẽ loại bỏ padding tự động
            //   shape: RoundedRectangleBorder(
            //     borderRadius:
            //         BorderRadius.circular(10), // Điều này tạo nút hình vuông
            //   ),
            //   minimumSize: Size(45, 45), // Kích thước tối thiểu của nút
            // ),
          ),
        ),
      ],
    );
  }

  void onCreated(GoogleMapController controller) async {
    _controller.complete(controller);
    print('LatLng( CURREN');
    print(widget.currentLocation.coordinates);
    addMarkerPicture('current', widget.currentLocation.coordinates, widget.icon,
        widget.currentLocation.heading);
    print('LatLng( CURREN2');

    for (LatLng point in widget.listDrive) {
      addMarkerPicture(const Uuid().v4(), point, 'assets/imgs/CarMap.png',
          Random().nextDouble() * 360 + 1);
    }
    if (widget.desLocation != null) addPolylineAndFitMap();
  }

  Future<void> addPolylineAndFitMap() async {
    addMarkerPicture(
        'des', widget.desLocation!.coordinates, 'assets/imgs/DesDetail.png', 0);
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
    print('LatLng( 1111111111');

    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }

  Future<void> addMarkerPicture(
      String id, LatLng location, String assetName, double rotate) async {
    // BitmapDescriptor.fromAssetImage(configuration, assetName)
    if (mounted) {
      BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(60, 60)),
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
  }

  Future<void> addMarkerSVG(
      String id, LatLng location, String assetName, double rotate) async {
    print("LatLng( $assetName");
    BitmapDescriptor svgIcon =
        await getBitmapDescriptorFromSvgAsset(assetName, const Size(40, 40));
    print("LatLng( $svgIcon");
    if (mounted) {
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
}
