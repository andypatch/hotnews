import 'package:flutter/material.dart';
import 'package:hotnews/bimbi/models/b_customer.dart';
import 'package:hotnews/bimbi/screens/b_maps.dart';
import 'package:url_launcher/url_launcher.dart';

import 'b_bustomer_status_row.dart';
import 'b_buttom_buttons.dart';
import 'b_container_bimby.dart';
import 'b_customer_details_info.dart';

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
          bCustomerDetailsInfo(customerSelected: customerSelected),
          SizedBox(
            height: 15,
          ),
          b_bottom_buttons(customerSelected: customerSelected),
        ]),
      ),
    );
  }
}
