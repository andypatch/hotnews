import 'dart:convert';
import 'package:hotnews/models/article.dart';
import 'package:hotnews/models/articlesRepo.dart';

import 'package:flutter/material.dart';
import 'package:hotnews/screens/main_drawer.dart';
import 'package:hotnews/screens/news_detail.dart';
import 'package:provider/provider.dart';
import 'package:hotnews/services/api.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:hotnews/screens/main_drawer.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key key}) : super(key: key);
  @override
  _MyHomeState createState() => _MyHomeState();
}


class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final List<Tab> myTabs = <Tab>[
    //Tab(icon: Icon(Icons.search)),
    Tab(text: 'General'),
    Tab(text: 'Health'),
    Tab(text: 'Technology'),
  ];

  TabController _tabController;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    Api().fetchArticles(context: context, category: 'general');
    Api().fetchArticles(context: context, category: 'health');
    Api().fetchArticles(context: context, category: 'technology');

    //TODO: delete shared prefs
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
        title: Text('Hot News'),
        centerTitle: true,
        bottom: TabBar(
          indicatorWeight: 2,
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      drawer:MainDrawer(),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          return Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: listNewCreator(tab.text.toLowerCase()),
            ),
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

  Widget listNewCreator(var tabcategory) {
    return Consumer<ArticlesRepo>(builder: (context, news, child) {
      if (news.getArticles(tabcategory) != null) {
        return ListView.builder(
          itemCount: news.getArticles(tabcategory).length,
          itemBuilder: (context, position) => Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                children: <Widget>[
                  new GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewsDetail(
                                  news.getArticles(tabcategory)[position])));
                    },
                    child: news
                            .getArticles(tabcategory)[position]
                            .urlToImage != null ? Image(
                        image: NetworkImage(news
                            .getArticles(tabcategory)[position]
                            .urlToImage)) : Text(''),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                            news.getArticles(tabcategory)[position].title,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black45)),
                      ),
                      GestureDetector(
                        onTap: () {
                          manageFav(news.getArticles(tabcategory)[position]);
                        },
                        child: manageFavIcons(
                            news, news.getArticles(tabcategory)[position]),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      } else {
        return CircularProgressIndicator();
      }
    });
  }

  Future manageFav(Article favSelected) async {
    final SharedPreferences prefs = await _prefs;
    var articlesHolder = Provider.of<ArticlesRepo>(context, listen: false);
    // check exists

    String check = prefs.getString(favSelected.url) ?? 'not available';
    print('################################# shared pref check ${favSelected.title} => $check');
    if (prefs.getString(favSelected.url) == null) {
      prefs
          .setString(favSelected.url, json.encode(favSelected))
          .then((bool success) {
        print(
            '################################# shared pref saved ${favSelected.title}');
        
        articlesHolder.addToFavArticles(favSelected);
      });
    }
    else
    {
        articlesHolder.removeFavArticles(favSelected);
    }
  }

  Widget manageFavIcons(ArticlesRepo mynews, Article current) {
    for (var i = 0; i < mynews.favArticles.length; i++) {
      if (mynews.favArticles[i].url == current.url) {
        return Icon(
          Icons.favorite,
          color: Colors.red,
        );
      }
    }

    return Icon(Icons.favorite_border);
  }
}
