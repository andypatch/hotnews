import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:hotnews/bimbi/components/b_detailbar.dart';
import 'package:hotnews/bimbi/components/b_container_bimby.dart';

class b_MapDetail extends StatefulWidget {
  @override
  _b_MapDetailState createState() => _b_MapDetailState();
}

class _b_MapDetailState extends State<b_MapDetail> {
  final _key = GlobalKey<GoogleMapStateBase>();

  bool _polygonAdded = false;
  bool _darkMapStyle = false;
  String _mapStyle;

  List<Widget> _buildInfo() => [
        Column(children: <Widget>[
          Container(
            child: Row(children: <Widget>[
              Column(
                children: <Widget>[
                  Text("",
                      style: TextStyle(
                          color: Colors.green[700],
                          fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(width: 10),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        "GUERRA ANNALISA",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(height: 2),
                    Flexible(
                      child: Text(
                        "Viale Vesuvio, 18 - 20128 Milano",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ]),
            ]),
          ),
          Container(
            child: Row(
              children: <Widget>[
              RaisedButton(
                color: Colors.green[700],
                textColor: Colors.white,
                child: Text(
                  "Open in Google Maps",
                  style: TextStyle(fontSize: 12),
                ),
                onPressed: () {
                  GoogleMap.of(_key).clearPolygons();
                  setState(() => _polygonAdded = false);
                },
              ),
            ]),
          ),
        ]),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BdetailBar('Mappa'),
      body: Stack(children: <Widget>[
        GoogleMap(
            key: _key,
            initialPosition: GeoCoord(34, -118),
            initialZoom: 12,
            mapType: MapType.roadmap,
            interactive: true,
            markers: {
              Marker(GeoCoord(34, -118)),
            }),
        Positioned(
          left: 16,
          right: 16,

          ///kIsWeb ? 60 : 16,
          bottom: 16,

          child: ContainerBimby(
            Row(children: _buildInfo()),
          ),
        ),
      ]),
    );
  }
}
