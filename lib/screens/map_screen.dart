import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_map_arcgis/flutter_map_arcgis.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map-screen';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // final Map<String, double> Dest;

  var _latitude;
  var _longitude;
  var _altitude = "";
  var _speed = "";
  var _address = "";

  Future<void> _updatePosition() async {
    Position pos = await _determinePosition();
    List pm = await placemarkFromCoordinates(pos.latitude, pos.longitude);
    setState(() {
      _latitude = pos.latitude.toDouble();
      _longitude = pos.longitude.toDouble();
      _altitude = pos.altitude.toString();
      _speed = pos.speed.toString();

      _address = pm[0].toString();
    });
  }

  var _loadedInitData = false;
  // // late Map<String, double> coOrdinates;
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (!_loadedInitData) {
  //     final routeArgs =
  //         ModalRoute.of(context)?.settings.arguments as Map<String, double>;
  //     Dest['latitude'] = routeArgs['latitude']!;
  //     Dest['longitude'] = routeArgs['longitude']!;
  //   }
  //   _loadedInitData = true;
  // }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore',
          style: TextStyle(
            color: Colors.white,
            fontStyle: FontStyle.italic,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegate(),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(16.84395552735782, 74.60173842596902),
                  // center: LatLng(47.925812, 106.919831),
                  // pinchZoomThreshold: 0.5,
                  // pinchZoomWinGestures: 25,
                  // pinchMoveThreshold: 15,
                  zoom: 17.5,
                  rotation: 0,
                  keepAlive: true,
                  interactiveFlags:
                      InteractiveFlag.all & ~InteractiveFlag.rotate,
                  bounds: LatLngBounds(
                    LatLng(16.844520514826883, 74.59821532994178),
                    LatLng(16.842341570446195, 74.60467173950599),
                  ),
                  // rotationThreshold: 20.0,
                  // pinchZoomThreshold: 0.5,
                  plugins: [EsriPlugin()],
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'http://{s}.google.com/vt/lyrs=m&x={x}&y={y}&z={z}',
                    subdomains: ['mt0', 'mt1', 'mt2', 'mt3'],
                  ),
                  // MarkerLayerOptions(
                  //   markers: [
                  //     Marker(
                  //       // point: LatLng(num.tryParse(_latitude)!.toDouble(),
                  //       //     num.tryParse(_longitude).toDouble()),
                  //       point:
                  //           LatLng(_latitude.toDouble(), _longitude.toDouble()),
                  //       builder: (ctx) {
                  //         return Container();
                  //       },
                  //     ),
                  //     Marker(
                  //         point: LatLng(
                  //             _latitude.toDouble(), _longitude.toDouble()),
                  //         builder: (ctx) {
                  //           return Container();
                  //         })
                  //   ],
                  // ),
                  FeatureLayerOptions(
                    "https://services.arcgis.com/P3ePLMYs2RVChkJx/arcgis/rest/services/USA_Congressional_Districts/FeatureServer/0",
                    "polygon",
                    onTap: (dynamic attributes, LatLng location) {
                      print(attributes);
                    },
                    render: (dynamic attributes) {
                      // You can render by attribute
                      return const PolygonOptions(
                          borderColor: Colors.blueAccent,
                          color: Colors.black12,
                          borderStrokeWidth: 2);
                    },
                  ),
                  FeatureLayerOptions(
                    "https://services.arcgis.com/V6ZHFr6zdgNZuVG0/arcgis/rest/services/Landscape_Trees/FeatureServer/0",
                    "point",
                    render: (dynamic attributes) {
                      // You can render by attribute
                      return const PointOptions(
                        width: 30.0,
                        height: 30.0,
                        builder: Icon(Icons.pin_drop),
                      );
                    },
                    onTap: (attributes, LatLng location) {
                      print(attributes);
                    },
                  ),
                  FeatureLayerOptions(
                    "https://services.arcgis.com/V6ZHFr6zdgNZuVG0/ArcGIS/rest/services/Denver_Streets_Centerline/FeatureServer/0",
                    "polyline",
                    render: (dynamic attributes) {
                      // You can render by attribute
                      return const PolygonLineOptions(
                          borderColor: Colors.red,
                          color: Colors.red,
                          borderStrokeWidth: 2);
                    },
                    onTap: (attributes, LatLng location) {
                      print(attributes);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  List<String> searchResults = [
    'CSE Department',
    'Mini-CCF',
    'CCF',
    'Cyber hostel',
    'Boys Hostel',
    'Lipton',
    'Canteen',
    'Rector office',
    'Exam Cell',
    'Library',
    'Saraswati Idol'
  ];
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: Icon(
            Icons.clear,
          ),
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: Icon(
          Icons.arrow_back,
        ),
      );

  @override
  Widget buildResults(BuildContext context) => MapScreen();

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> suggestions = searchResults.where((searchResult) {
      final result = searchResult.toLowerCase();
      final input = query.toLowerCase();

      return result.contains(input);
    }).toList();
    return ListView.builder(
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];

        return ListTile(
          title: Text(suggestion),
          onTap: () {
            query = suggestion;
            showResults(context);
          },
        );
      },
      itemCount: suggestions.length,
    );
    // throw UnimplementedError();
  }
}
