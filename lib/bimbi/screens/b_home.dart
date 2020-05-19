import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotnews/bimbi/components/b_appbar.dart';
import 'package:hotnews/bimbi/components/b_bottombar.dart';
import 'package:hotnews/bimbi/components/container_bimby.dart';

class bHome extends StatefulWidget  {
  bHome({Key key}) : super(key: key);

  @override
  _bHomeState createState() => _bHomeState();
}

class _bHomeState extends State<bHome> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BappBar("Home"),
      body: Container(
        padding: EdgeInsets.all(16),
        color: Colors.grey[300],
        child: Column(
          children: <Widget>[
            ContainerBimby(
              Row(children: <Widget>[
                Flexible(
                  child: Text(
                    "Ciao ",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Flexible(
                  child: Text(
                    "George Folleto",
                    style: TextStyle(fontSize: 18, color: Colors.green[700]),
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: <Widget>[
                ContainerBimby(
                  Row(children: <Widget>[
                    Container(
                      width: 250,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                "Lista Clienti",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.green[700]),
                              ),
                            ),
                            SizedBox(height: 10),
                            Flexible(
                              child: Text(
                                "Accedi alla tua lista clienti, consulta i dettagli e crea la tua lista da lavorare.",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                          ]),
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      fontSize: 46, color: Colors.green[700]),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ]),
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.green[700],
                      child: Icon(Icons.arrow_forward, color: Colors.white),
                    ))
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BbottomBar(),
    );
  }
}



//Text("",style:  TextStyle(fontFamily: 'Bimby', fontSize: 30),)
