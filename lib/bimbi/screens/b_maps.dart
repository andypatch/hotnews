import 'package:flutter/material.dart';
import 'package:flutter_google_maps/flutter_google_maps.dart';
import 'package:hotnews/bimbi/components/b_detailbar.dart';
import 'package:hotnews/bimbi/components/b_container_bimby.dart';
import 'package:hotnews/bimbi/models/b_customer.dart';
import 'package:maps_launcher/maps_launcher.dart';

class b_MapDetail extends StatefulWidget {
  final Customer customerSelected;

  b_MapDetail(this.customerSelected);
  @override
  _b_MapDetailState createState() => _b_MapDetailState();
}

class _b_MapDetailState extends State<b_MapDetail> {
  final _key = GlobalKey<GoogleMapStateBase>();

  bool _polygonAdded = false;
  bool _darkMapStyle = false;
  String _mapStyle;

  Widget _buildInfo() => Column(
        children: <Widget>[
          ContainerBimby(
            Column(children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
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
                                widget.customerSelected.firstName +
                                    " " +
                                    widget.customerSelected.surName,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            SizedBox(height: 2),
                            Flexible(
                              child: Text(
                                widget.customerSelected.address +
                                    ", " +
                                    widget.customerSelected.civic +
                                    " " +
                                    widget.customerSelected.zipCode +
                                    " - " +
                                    widget.customerSelected.city,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ]),
                    ]),
                  ],
                ),
              ),
            ]),
          ),
          ContainerBimby(
            Row(children: <Widget>[
              RaisedButton(
                color: Colors.green[700],
                textColor: Colors.white,
                child: SizedBox(
                  width: 310,
                  child: Text(
                    "Open in Google Maps",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                onPressed: () {
                  MapsLauncher.launchCoordinates(
                      double.parse(widget.customerSelected.lat),
                      double.parse(widget.customerSelected.lon),
                      widget.customerSelected.address +
                          ", " +
                          widget.customerSelected.civic +
                          " " +
                          widget.customerSelected.zipCode +
                          " - " +
                          widget.customerSelected.city);
                },
              ),
            ]),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BdetailBar('Mappa'),
      body: Stack(children: <Widget>[
        GoogleMap(
            key: _key,
            initialPosition: GeoCoord(double.parse(widget.customerSelected.lat),
                double.parse(widget.customerSelected.lon)),
            initialZoom: 14,
            mapType: MapType.roadmap,
            interactive: true,
            markers: {
              Marker(
                  GeoCoord(double.parse(widget.customerSelected.lat),
                      double.parse(widget.customerSelected.lon)),
                  info: widget.customerSelected.surName,
                  infoSnippet: widget.customerSelected.firstName),
            }),
        Positioned(
          left: 16,
          right: 16,

          ///kIsWeb ? 60 : 16,
          bottom: 16,

          child: _buildInfo(),
        ),
      ]),
    );
  }
}
