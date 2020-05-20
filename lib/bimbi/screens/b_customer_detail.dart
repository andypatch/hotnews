import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotnews/bimbi/models/b_customer.dart';

import 'package:webview_flutter/webview_flutter.dart';

class CustomerDetail extends StatelessWidget {
  final Customer customerSelected;

  CustomerDetail(this.customerSelected) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: WebView(
        initialUrl: customerSelected.address,
        javascriptMode: JavascriptMode.unrestricted,
      )
    );
  }
}
