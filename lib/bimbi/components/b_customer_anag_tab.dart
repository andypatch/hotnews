import 'package:flutter/material.dart';
import 'package:hotnews/bimbi/models/b_customer.dart';

import 'b_container_bimby.dart';

class customerAnagTab extends StatelessWidget {
  final Customer customerSelected;

  customerAnagTab(this.customerSelected);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.grey[300],
        child: Column(children: <Widget>[
          ContainerBimby(
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("",
                        style: TextStyle(
                            color: Colors.green[700], fontSize: 18.0)),
                    SizedBox(width: 5),
                    Text(
                        customerSelected.firstName +
                            " " +
                            customerSelected.surName,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 1,
                  endIndent: 5,
                ),
                buildCustomerStatusRow(),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SingleChildScrollView(
            child: Column(children: <Widget>[
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 2,
                child: Row(children: <Widget>[
                  Text(
                    "Ciao ",
                    style: TextStyle(fontSize: 18),
                  ),
                ]),
              ),
            ]),
          ),
          SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }

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
}
