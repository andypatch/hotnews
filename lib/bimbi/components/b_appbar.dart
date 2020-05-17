import 'package:flutter/material.dart';


class BappBar extends StatefulWidget  implements PreferredSizeWidget {

  @override
  _BappBarState createState() => _BappBarState();

  Size get preferredSize {
    return new Size.fromHeight(50.0);
  }

}

class _BappBarState extends State<BappBar> {
  @override
  Widget build(BuildContext context) {
    return  AppBar(
        backgroundColor: Colors.white,
        title: Row(
          children: <Widget>[
            Container(
                height: 22,
                child: Image(
                  image: AssetImage('assets/bimby.png'),
                )),
            Expanded(
              child: Container(),
            ),
            Text("HOME",
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




