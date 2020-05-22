
import 'package:flutter/material.dart';

Widget buildCustomerActivityRow() {
    return Row(children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Ultimod mod",
                      style: TextStyle(color: Colors.black, fontSize: 10)),
                  Text("TM6",
                      style: TextStyle(color: Colors.black, fontSize: 10)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Ultimo acquisto",
                      style: TextStyle(color: Colors.black, fontSize: 10)),
                  Text("21/05/2020",
                      style: TextStyle(color: Colors.black, fontSize: 10)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Tipo",
                      style: TextStyle(color: Colors.black, fontSize: 10)),
                  Text("N7D",
                      style: TextStyle(color: Colors.black, fontSize: 10)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Ultimod contatto",
                      style: TextStyle(color: Colors.black, fontSize: 10)),
                  Text("Nessuno",
                      style: TextStyle(color: Colors.red, fontSize: 10)),
                ],
              ),
            ),
          ]);
  }

  Widget buildCustomerStatusRow() {
    return Row(children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("",
                      style: TextStyle(color: Colors.green[700], fontSize: 30)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("",
                      style: TextStyle(color: Colors.grey, fontSize: 30)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("",
                      style: TextStyle(color: Colors.grey, fontSize: 30)),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("",
                      style: TextStyle(color: Colors.grey, fontSize: 30)),
                ],
              ),
            ), 
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("",
                      style: TextStyle(color: Colors.grey, fontSize: 30)),
                ],
              ),
            ),                                    
          ]);
  }