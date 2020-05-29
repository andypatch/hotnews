import 'package:flutter/material.dart';
import 'package:hotnews/bimbi/models/b_customer.dart';
import 'package:url_launcher/url_launcher.dart';

class b_bottom_buttons extends StatelessWidget {
  const b_bottom_buttons({
    Key key,
    @required this.customerSelected,
  }) : super(key: key);

  final Customer customerSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          MaterialButton(
            minWidth: 140,
            elevation: 5.0,
            padding: EdgeInsets.all(5.0),
            color: Colors.green[700],
            child: Text("Mail",
                style: TextStyle(color: Colors.white, fontSize: 14.0)),
            onPressed: () => launch("mailto:${customerSelected.email}'"),
          ),
          MaterialButton(
            minWidth: 140,
            elevation: 5.0,
            color: Colors.green[700],
            padding: EdgeInsets.all(5.0),
            child: Text("Chiama",
                style: TextStyle(color: Colors.white, fontSize: 14.0)),
            onPressed: () => launch("tel://${customerSelected.phone}"),
          )
        ],
      ),
    );
  }
}
