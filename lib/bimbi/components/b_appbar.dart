import 'package:flutter/material.dart';
import 'package:hotnews/bimbi/models/b_customersBloc.dart';
import 'package:hotnews/bimbi/models/b_customersRepo.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'b_account_info.dart';

class BappBar extends StatefulWidget implements PreferredSizeWidget {
  String title = "";

  BappBar(this.title) {}
  @override
  _BappBarState createState() => _BappBarState();

  Size get preferredSize {
    return new Size.fromHeight(50);
  }
}

class _BappBarState extends State<BappBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        children: <Widget>[
          Container(
              height: 18,
              child: Image(
                image: AssetImage('assets/bimby.png'),
              )),
          Expanded(
            child: Container(),
          ),
          Text(widget.title,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          Expanded(
            child: Container(),
          ),
          new GestureDetector(
            onTap: () {
              return buildAccountInfo(context).show();
            },
            child: Text("",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 12),
          Text("",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  
  get categories => CategoriesEnum.values
      .map((e) => Tab(text: categoryName(e).toUpperCase()))
      .toList();
}
