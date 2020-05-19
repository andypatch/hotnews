import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotnews/bimbi/components/b_appbar.dart';
import 'package:hotnews/bimbi/components/b_bottombar.dart';
import 'package:hotnews/bimbi/components/container_bimby.dart';

class bCustomerList extends StatefulWidget {
  bCustomerList({Key key}) : super(key: key);

  @override
  _bCustomerListState createState() => _bCustomerListState();
}

class _bCustomerListState extends State<bCustomerList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BappBar("Clienti"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(children: <Widget>[
            Text("Totale: " + "290"),
            Expanded(child: Text("")),
            Text(
              " ",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            Text(
              " ",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),  
            Text(
              "",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),                      
          ]),
        ),
      ),
      bottomNavigationBar: BbottomBar(),
    );
  }
}

//Text("",style:  TextStyle(fontFamily: 'Bimby', fontSize: 30),)
