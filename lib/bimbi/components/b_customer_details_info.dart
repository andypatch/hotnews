import 'package:flutter/material.dart';
import 'package:hotnews/bimbi/models/b_customer.dart';
import 'package:hotnews/bimbi/screens/b_maps.dart';

class bCustomerDetailsInfo extends StatelessWidget {
  const bCustomerDetailsInfo({
    Key key,
    @required this.customerSelected,
  }) : super(key: key);

  final Customer customerSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0))
      ]),
      height: MediaQuery.of(context).size.height / 1.91,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("Indirizzo",
                      style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold)),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                b_MapDetail(customerSelected)));
                  },
                  child: Text(" ",
                      style: TextStyle(
                          color: Colors.green[700], fontSize: 18.0)),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Cap",
                            style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 12.0)),
                        Text(customerSelected.zipCode,
                            style: TextStyle(fontSize: 12.0)),
                      ]),
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Comune",
                            style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 12.0)),
                        Text(customerSelected.city,
                            style: TextStyle(fontSize: 12.0)),
                      ]),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Telefono",
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 12.0)),
                      Text(customerSelected.phone,
                          style: TextStyle(fontSize: 12.0)),
                    ]),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                        Text("Codice Fiscale",
                            style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 12.0)),
                        Text('MNTNRM72A28701U',
                            style: TextStyle(fontSize: 12.0)),
                      ]),
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Partita Iva",
                          style: TextStyle(
                              color: Colors.green[700], fontSize: 12.0)),
                      Text("43284238746",
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
                  child: Text("Altri Dati",
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
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(" Consenso privacy",
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
                  child: Text("Note",
                      style: TextStyle(
                          color: Colors.green[700],
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold)),
                ),
                Text("",
                    style: TextStyle(
                        color: Colors.green[700], fontSize: 18.0)),
              ],
            ),
            SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }
}

