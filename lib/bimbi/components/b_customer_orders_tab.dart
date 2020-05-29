import 'package:flutter/material.dart';
import 'package:hotnews/bimbi/models/b_customer.dart';

import 'b_activity_table.dart';
import 'b_bustomer_status_row.dart';
import 'b_buttom_buttons.dart';
import 'b_container_bimby.dart';

class customerOrdersTab extends StatelessWidget {
  final Customer customerSelected;

  customerOrdersTab(this.customerSelected);

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
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0))
            ]),
            height: 120,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Ordini",
                            style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Data ultimo acquisto: 28/01/2020",
                          style: TextStyle(fontSize: 12.0)),
                      SizedBox(width: 5),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("TM21",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              Text('0', style: TextStyle(fontSize: 12.0)),
                            ]),
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("TM31",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              Text('0', style: TextStyle(fontSize: 12.0)),
                            ]),
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("TM% bs",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              Text('0', style: TextStyle(fontSize: 12.0)),
                            ]),
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("TM5 ck",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              Text('0', style: TextStyle(fontSize: 12.0)),
                            ]),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("TM6",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12.0)),
                            Text("0", style: TextStyle(fontSize: 12.0)),
                          ]),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0))
            ]),
            height: 225,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text("Attività",
                            style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Ultimo Contatto",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              Text('Nessuno', style: TextStyle(fontSize: 12.0)),
                            ]),
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Ultimo Evento",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12.0)),
                              Text('Nessuno', style: TextStyle(fontSize: 12.0)),
                            ]),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  b_activity_table(),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          b_bottom_buttons(customerSelected: customerSelected),
        ]),
      ),
    );
  }
}
