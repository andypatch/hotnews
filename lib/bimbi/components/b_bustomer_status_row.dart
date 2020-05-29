  import 'package:flutter/material.dart';

Widget buildCustomerStatusRow() {
    return Row(children: <Widget>[
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("", style: TextStyle(color: Colors.green[700], fontSize: 30)),
          ],
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("", style: TextStyle(color: Colors.grey, fontSize: 30)),
          ],
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("", style: TextStyle(color: Colors.grey, fontSize: 30)),
          ],
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("", style: TextStyle(color: Colors.grey, fontSize: 30)),
          ],
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("", style: TextStyle(color: Colors.grey, fontSize: 30)),
          ],
        ),
      ),
    ]);
  }