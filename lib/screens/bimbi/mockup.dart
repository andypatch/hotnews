import 'package:flutter/material.dart';

class TodoApp extends StatelessWidget {
  final List tasks = [
    {"title":"Comprare il pane", "completed": true},
    {"title":"Aggiungere l'esempio alle slide", "completed": false},
    {"title":"14:00 corso flutter", "completed": false},
    {"title":"18:00 goderti la quarantena", "completed": false},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            header(),
            Row(
              children: <Widget>[
                Text(
                  "Oggi",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 42.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 100),
                Text(
                  "Domani",
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 42.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            // ...tasks.map((task) => Padding(
            //   padding: const EdgeInsets.only(left: 10.0),
            //   child: ListTile(
            //     title: Text(task["title"], style: TextStyle(
            //       decoration: task["completed"] ? TextDecoration.lineThrough : TextDecoration.none,
            //       decorationColor: Colors.red,
            //       fontSize: 22.0,
            //       color: Colors.black
            //     )))),),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
              height: 50,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(width: 20),
                    IconButton(icon: Icon(Icons.menu, size: 30)),
                  ]))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    ));
  }

  header() {
    return Container(
      height: 220,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: -130,
            top: -150,
            child: Container(
              width: 350,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient:
                      LinearGradient(colors: [Colors.black26, Colors.green]),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green,
                        offset: Offset(92.0, 4.0),
                        blurRadius: 10.0)
                  ]),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [Colors.green, Colors.green]),
                boxShadow: [
                  BoxShadow(
                      color: Colors.green,
                      offset: Offset(1.0, 1.0),
                      blurRadius: 4.0)
                ]),
          ),
          Positioned(
            top: 100,
            left: 140,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: [Colors.blue, Colors.green]),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green,
                        offset: Offset(1.0, 1.0),
                        blurRadius: 4.0)
                  ]),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 90, left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Time to work",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10.0),
                Text(
                  "Time to go!!!",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  listaTodo() {
            return tasks.map((task)=>Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ListTile(
                title: Text(task["title"], style: TextStyle(
                  decoration: task["completed"] ? TextDecoration.lineThrough : TextDecoration.none,
                  decorationColor: Colors.red,
                  fontSize: 22.0,
                  color: Colors.black
                ),),),),);

  }
}
