// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:hotnews/models/articlesRepo.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key key}) : super(key: key);
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final List<Tab> myTabs = <Tab>[
    Tab(text: 'Recenti'),
    Tab(text: 'Italia'),
    Tab(text: 'Mondo'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          return Center(
            child: Consumer<ArticlesRepo>(builder: (context, news, child) {
              return ListView.builder(
                  itemCount: news.articles.length,
                  itemBuilder: (context, position) => Text(
                        news.articles[position].title,
                      ));
            }),
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (currentIndex) {
          setState(() {
            _currentIndex = currentIndex;
          });
          _tabController.animateTo(_currentIndex);
        },
        items: [
          BottomNavigationBarItem(
              title: Text("For you"), icon: Icon(Icons.airplanemode_active)),
          BottomNavigationBarItem(
              title: Text("News"), icon: Icon(Icons.new_releases)),
          BottomNavigationBarItem(
              title: Text("Favourites"), icon: Icon(Icons.label_important)),
        ],
      ),
    );
  }
}

// class MyHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         child: new Center(
//           child: Consumer<ArticlesRepo>(builder: (context, news, child) {
//             return ListView.builder(
//                 itemCount: news.articles.length,
//                 itemBuilder: (context, position) => Text(
//                       news.articles[position].title,
//                     ));
//           }),
//         ),
//       ),
//     );
//   }
// }
