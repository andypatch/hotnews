import 'package:flutter/material.dart';

class BbottomBar extends StatefulWidget {
  
  const BbottomBar();

  @override
  _BbottomBarState createState() => _BbottomBarState();
}

class _BbottomBarState extends State<BbottomBar> {
  bool bottomStatusOpen = false;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: AnimatedContainer(
        padding: EdgeInsets.all(15.0),
        height: bottomStatusOpen ? 120.0 : 50.0,
        duration: Duration(milliseconds: 200),
        color: Colors.green[700],
        child: Row(
          children: <Widget>[
            Container(
              alignment:
                  bottomStatusOpen ? Alignment.topLeft : Alignment.centerLeft,
              child: Flexible(
                child: Text(
                  "Vorwerk Bimby",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  bottomStatusOpen = !bottomStatusOpen;
                });
              },
              child: Container(
                alignment: bottomStatusOpen
                    ? Alignment.topLeft
                    : Alignment.centerRight,
                child: Flexible(
                  child: Text(
                    bottomStatusOpen ? "Chiudi Footer" : "Apri footer",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}