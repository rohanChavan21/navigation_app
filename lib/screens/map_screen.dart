import 'package:flutter/material.dart';
import 'package:flutter_map_arcgis/flutter_map_arcgis.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  static const routeName = '/map-screen';
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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
      )),
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
                  FeatureLayerOptions(
                    "https://services.arcgis.com/P3ePLMYs2RVChkJx/arcgis/rest/services/USA_Congressional_Districts/FeatureServer/0",
                    "polygon",
                    onTap: (dynamic attributes, LatLng location) {
                      print(attributes);
                    },
                    render: (dynamic attributes) {
                      // You can render by attribute
                      return PolygonOptions(
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
                      return PointOptions(
                        width: 30.0,
                        height: 30.0,
                        builder: const Icon(Icons.pin_drop),
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
                      return PolygonLineOptions(
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
