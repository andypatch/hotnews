import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Alert buildAccountInfo(BuildContext context) {
    return Alert(
        context: context,
        title: " PROFILO",
        style: AlertStyle(
          titleStyle: TextStyle(color: Colors.green[700], fontSize: 16.0),
        ),
        content: Column(
          children: <Widget>[
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 1,
              endIndent: 5,
            ), 
            Row(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Area",
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 12.0)),
                      Text("040 - ANACHILDE GENTILI",
                          style: TextStyle(fontSize: 14.0)),
                    ]),
              ],
            ), 
            SizedBox(
              height: 5,
            ),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 1,
              endIndent: 5,
            ), 
            Row(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Divisione",
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 12.0)),
                      Text("040 - ANACHILDE GENTILI",
                          style: TextStyle(fontSize: 14.0)),
                    ]),
              ],
            ), 
            SizedBox(
              height: 5,
            ),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 1,
              endIndent: 5,
            ), 
            Row(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Team",
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 12.0)),
                      Text("Dream team",
                          style: TextStyle(fontSize: 14.0)),
                    ]),
              ],
            ), 
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 1,
              endIndent: 5,
            ),
            Row(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Incaricato",
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 12.0)),
                      Text("Giorgio Panetta",
                          style: TextStyle(fontSize: 14.0)),
                    ]),
              ],
            ),
            SizedBox(
              height: 5,
            ),  
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 1,
              endIndent: 5,
            ), 
            Row(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Codice",
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 12.0)),
                      Text("7970895",
                          style: TextStyle(fontSize: 14.0)),
                    ]),
              ],
            ),    
            SizedBox(
              height: 5,
            ),                                                                             
          ],
        ),
        buttons: []);
  }
