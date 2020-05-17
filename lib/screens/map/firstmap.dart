import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';

class firstMap extends StatefulWidget {

  @override
  _firstMapState createState() => _firstMapState();
}

class _firstMapState extends State<firstMap> {

  final _key = GlobalKey<GoogleMapStateBase>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: GoogleMap(
         key: _key,
         initialPosition: GeoCoord(34, -118),
         initialZoom: 12,
         mapType: MapType.roadmap,
         interactive: true,
         markers: {Marker(GeoCoord(34,-118)),}
       ),
    );
  }
}