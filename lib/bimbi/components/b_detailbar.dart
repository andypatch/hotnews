import 'package:flutter/material.dart';


class BdetailBar extends StatefulWidget  implements PreferredSizeWidget {

  @override
  _BdetailBarState createState() => _BdetailBarState();
  String pageTitle="";

  BdetailBar(this.pageTitle);

  Size get preferredSize {
    return new Size.fromHeight(50.0);
  }

}

class _BdetailBarState extends State<BdetailBar> {
  @override
  Widget build(BuildContext context) {
    return  AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Text("",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            Expanded(
              child: Container(),
            ),
            Text(widget.pageTitle,
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            Expanded(
              child: Container(),
            ),
            Text("",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            SizedBox(width: 12),
            Text("",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ],
        ),
      );
  }
}




