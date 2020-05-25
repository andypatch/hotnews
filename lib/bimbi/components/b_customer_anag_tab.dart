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
          ContainerBimby(
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("Indirizzo",
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 14.0,fontWeight: FontWeight.bold )),
                    ),
                    Text(" ",
                        style: TextStyle(
                            color: Colors.green[700], fontSize: 18.0)),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    Text(
                        customerSelected.address +
                            ', ' +
                            customerSelected.civic,
                        style: TextStyle(fontSize: 14.0)),
                    SizedBox(width: 5),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 1,
                  endIndent: 5,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Text("Cap",
                            style: TextStyle(
                                color: Colors.green[700], fontSize: 12.0)),
                        Text(customerSelected.zipCode,
                            style: TextStyle(fontSize: 12.0)),
                      ]),
                    ),
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Text("Comune",
                            style: TextStyle(
                                color: Colors.green[700], fontSize: 12.0)),
                        Text(customerSelected.city,
                            style: TextStyle(fontSize: 12.0)),
                      ]),
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Text("Provincia",
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 12.0)),
                      Text("PL", style: TextStyle(fontSize: 12.0)),
                    ]),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 1,
                  endIndent: 5,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("Contatti",
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 14.0,fontWeight: FontWeight.bold )),
                    ),

                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Text("Telefono",
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 12.0)),
                      Text(customerSelected.phone,
                          style: TextStyle(fontSize: 12.0)),
                    ]),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Text("Indirizzo email",
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 12.0)),
                      Text(customerSelected.email,
                          style: TextStyle(fontSize: 12.0)),
                    ]),
                  ],
                ),
                const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 1,
                  endIndent: 5,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text("Dati Fiscali",
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 14.0,fontWeight: FontWeight.bold )),
                    ),

                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                        Text("Codice Fiscale",
                            style: TextStyle(
                                color: Colors.green[700], fontSize: 12.0)),
                        Text('MNTNRM72A28701U',
                            style: TextStyle(fontSize: 12.0)),
                      ]),
                    ),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Text("Partita Iva",
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 12.0)),
                      Text("43284238746", style: TextStyle(fontSize: 12.0)),
                    ]),
                  ],
                ),

                const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 1,
                  endIndent: 5,
                ),
              ],
            ),
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
