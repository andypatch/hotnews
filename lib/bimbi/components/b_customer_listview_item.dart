import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hotnews/bimbi/models/b_customer.dart';
import 'package:hotnews/bimbi/models/b_customersRepo.dart';
import 'package:hotnews/bimbi/screens/b_customer_detail.dart';

import 'package:share/share.dart';

import '../../main.dart';

class CustomerItem extends StatefulWidget {
  final Customer customer;

  CustomerItem(this.customer, {Key key}) : super(key: key);

  @override
  _CustomerItemState createState() => _CustomerItemState();
}

class _CustomerItemState extends State<CustomerItem> {
  Box<Customer> customerToWorkBox;

  @override
  void initState() {
    super.initState();
    customerToWorkBox = Hive.box(CustomerToWorkBox);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(children: <Widget>[
            new GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomerDetail(widget.customer)));
              },
              child: Row(
                children: <Widget>[
                  Text("",
                      style:
                          TextStyle(color: Colors.green[700], fontSize: 18.0)),
                  SizedBox(width: 5),
                  Text(
                      widget.customer.firstName + " " + widget.customer.surName,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 25,
                ),
                Expanded(
                  child: Text(
                      widget.customer.address +
                          " " +
                          widget.customer.civic +
                          ", " +
                          widget.customer.zipCode +
                          " " +
                          widget.customer.city,
                      style: TextStyle(color: Colors.black, fontSize: 12)),
                ),
                SizedBox(
                  width: 15,
                ),
                Builder(
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        final RenderBox box = context.findRenderObject();
                        Share.share(widget.customer.firstName,
                            subject: 'News sharing',
                            sharePositionOrigin:
                                box.localToGlobal(Offset.zero) & box.size);
                      },
                      child: Icon(Icons.share),
                    );
                  },
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    /// add or remove favourites from list
                    this.onFavoritePress(widget.customer);
                  },
                  child: manageToWorkIcons(widget.customer.id),
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              height: 20,
              thickness: 1,
              indent: 1,
              endIndent: 5,
            ),
            Row(children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Ultimod mod",
                        style: TextStyle(color: Colors.black, fontSize: 10)),
                    Text("TM6",
                        style: TextStyle(color: Colors.black, fontSize: 10)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Ultimo acquisto",
                        style: TextStyle(color: Colors.black, fontSize: 10)),
                    Text("21/05/2020",
                        style: TextStyle(color: Colors.black, fontSize: 10)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Tipo",
                        style: TextStyle(color: Colors.black, fontSize: 10)),
                    Text("N7D",
                        style: TextStyle(color: Colors.black, fontSize: 10)),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Ultimod contatto",
                        style: TextStyle(color: Colors.black, fontSize: 10)),
                    Text("Nessuno",
                        style: TextStyle(color: Colors.red, fontSize: 10)),
                  ],
                ),
              ),
            ]),
          ])),
    );
  }

  void onFavoritePress(Customer currentCustomer) {
    if (customerToWorkBox.containsKey(currentCustomer.id)) {
      customerToWorkBox.delete(currentCustomer.id);
    } else {
      customerToWorkBox.put(currentCustomer.id, currentCustomer);
    }
    final bloc = CustomersRepo.of(context).bloc;
    bloc.favouritesChange();
  }

  Widget manageToWorkIcons(String id) {
    if (customerToWorkBox.containsKey(id)) {
      return Icon(Icons.favorite, color: Colors.red);
    }
    return Icon(Icons.favorite_border);
  }
}
