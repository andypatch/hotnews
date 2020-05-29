import 'package:flutter/material.dart';

class b_activity_table extends StatelessWidget {
  const b_activity_table({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(
          color: Colors.grey,
          width: 0,
          style: BorderStyle.solid),
      children: [
        TableRow(children: [
          TableCell(
            child: Container(
                height: 30,
                color: Colors.black,
                child: Center(
                    child: Text('Attività',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0)))),
          ),
          TableCell(
            child: Container(
                height: 30,
                color: Colors.black,
                child: Center(
                    child: Text('Tot',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0)))),
          ),
        ]),
        TableRow(children: [
          TableCell(
              child: Container(
                  padding: EdgeInsets.all(5),
                  height: 30,
                  child: Text('Dimostrazioni',
                      style: TextStyle(fontSize: 14.0)))),
          TableCell(
            child: Container(
                color: Colors.grey[100],
                height: 30,
                child: Center(
                    child: Text('0',
                        style: TextStyle(fontSize: 14.0)))),
          ),
        ]),
        TableRow(children: [
          TableCell(
              child: Container(
                  padding: EdgeInsets.all(5),                              
                  height: 30,
                  child: Text('Post Vendita',
                      style: TextStyle(fontSize: 14.0)))),
          TableCell(
            child: Container(
                color: Colors.grey[100],
                height: 30,
                child: Center(
                    child: Text('0',
                        style: TextStyle(fontSize: 14.0)))),
          ),
        ]),
        TableRow(children: [
          TableCell(
              child: Container(
                  padding: EdgeInsets.all(5),                              
                  height: 30,
                  child: Text('Laboratori a casa',
                      style: TextStyle(fontSize: 14.0)))),
          TableCell(
            child: Container(
                color: Colors.grey[100],
                height: 30,
                child: Center(
                    child: Text('0',
                        style: TextStyle(fontSize: 14.0)))),
          ),
        ]),
        TableRow(children: [
          TableCell(
              child: Container(
                  padding: EdgeInsets.all(5),                              
                  height: 30,
                  child: Text('Corsi di cucina',
                      style: TextStyle(fontSize: 14.0)))),
          TableCell(
            child: Container(
                color: Colors.grey[100],
                height: 30,
                child: Center(
                    child: Text('0',
                        style: TextStyle(fontSize: 14.0)))),
          ),
        ]),
        TableRow(children: [
          TableCell(
              child: Container(
                  padding: EdgeInsets.all(5),                              
                  height: 30,
                  child: Text('Fiere',
                      style: TextStyle(fontSize: 14.0)))),
          TableCell(
            child: Container(
                color: Colors.grey[100],
                height: 30,
                child: Center(
                    child: Text('0',
                        style: TextStyle(fontSize: 14.0)))),
          ),
        ]),
        TableRow(children: [
          TableCell(
              child: Container(
                  padding: EdgeInsets.all(5),                              
                  height: 30,
                  child: Text('Visite',
                      style: TextStyle(fontSize: 14.0)))),
          TableCell(
            child: Container(
                color: Colors.grey[100],
                height: 30,
                child: Center(
                    child: Text('0',
                        style: TextStyle(fontSize: 14.0)))),
          ),
        ]),
        TableRow(children: [
          TableCell(
              child: Container(
                  padding: EdgeInsets.all(5),                              
                  height: 30,
                  child: Text('Corsi di cucina con amico',
                      style: TextStyle(fontSize: 14.0)))),
          TableCell(
            child: Container(
                color: Colors.grey[100],
                height: 30,
                child: Center(
                    child: Text('0',
                        style: TextStyle(fontSize: 14.0)))),
          ),
        ]),
      ],
    );
  }
}
