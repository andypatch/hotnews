import 'package:flutter/material.dart';
import 'package:hotnews/bimbi/models/b_customersBloc.dart';
import 'package:hotnews/bimbi/models/b_customersRepo.dart';

class BappBarCust extends StatefulWidget implements PreferredSizeWidget {
  String title = "";

  BappBarCust(this.title) {}
  @override
  _BappBarCustState createState() => _BappBarCustState();

  Size get preferredSize {
    return new Size.fromHeight(50);
  }
}

class _BappBarCustState extends State<BappBarCust> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(widget.title,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ],
      ),
      // bottom: PreferredSize(
      //   preferredSize: const Size.fromHeight(30.0),
      //   child: StreamBuilder<AppScreen>(
      //     stream: bloc.actualScreen,
      //     builder: (context, AsyncSnapshot<AppScreen> snapshot) {
      //       return Container(
      //         height: 40,
      //         child: TabBar(
      //           indicatorColor: Colors.green[700],
      //           isScrollable: false,
      //           labelColor: Colors.green[700],
      //           tabs: categories,
      //           controller: _tabController,
      //         ),
      //       );
      //     },
      //   ),
      // ),
    );
  }
}
