import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotnews/models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetail extends StatelessWidget {
  Article articleSelected;

  NewsDetail(this.articleSelected) ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: WebView(
        initialUrl: articleSelected.url,
        javascriptMode: JavascriptMode.unrestricted,
      )
      // Center(
      //   child: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: ListView(
      //       children: <Widget>[
      //         Column(
      //               children: <Widget>[
      //                 Image(
      //                     image: NetworkImage(articleSelected.urlToImage),
      //                 ),
      //                 SizedBox(
      //                   height: 10,
      //                 ),
      //                 Text(articleSelected.title,
      //                     style: TextStyle(fontSize: 16, color: Colors.black45)),
      //                 SizedBox(
      //                   height: 10,
      //                 ),
      //                 Text(articleSelected.content,
      //                     style: TextStyle(fontSize: 16, color: Colors.black45)),                    
      //               ],
      //             ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
