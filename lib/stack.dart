import 'package:flutter/material.dart';

class StackExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/ny.jpg'),
                    fit: BoxFit.fitHeight))),
        Positioned(
          bottom: 50,
          left: 16,
          right: 16,
          child: Card(
              elevation: 12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'New York',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize:28)), 
                    SizedBox( height: 10),
                    Text('loredsakj dla skadj òjda dasj')],
          ),
              )),
        )
      ],
    );
  }
}
