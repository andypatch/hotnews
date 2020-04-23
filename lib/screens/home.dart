import 'dart:convert';
import 'package:hotnews/models/article.dart';
import 'package:hotnews/models/articlesRepo.dart';
import 'package:flutter/material.dart';
import 'package:hotnews/screens/main_drawer.dart';
import 'package:hotnews/screens/news_detail.dart';
import 'package:provider/provider.dart';
import 'package:hotnews/services/api.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyHome extends StatefulWidget {
  const MyHome({Key key}) : super(key: key);
  @override
  _MyHomeState createState() => _MyHomeState();
}


class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  
  Widget _appBarTitle = new Text( 'HotNews' );
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  
  int _currentIndex = 0;
  final List<Tab> myTabs = <Tab>[
    //Tab(icon: Icon(Icons.search)),
    Tab(text: 'General'),
    Tab(text: 'Health'),
    Tab(text: 'Technology'),
  ];
  TabController _tabController;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Icon _searchIcon = new Icon(Icons.search);
  List filteredNames = new List();  
  
  _MyHomeState(){
    _filter.addListener(() {
        // recupero  oggetto lista da articlerepo map
        var articlesHolder = Provider.of<ArticlesRepo>(context, listen: false);        
        if (_filter.text.isEmpty) {
          setState(() {
            _searchText = "";
            filteredNames = articlesHolder.getArticles('all');
          });
        } else {
          setState(() {
            _searchText = _filter.text;
          });
        }
      });
  }

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

  void _onItemTapped(int index) {
    var articlesHolder = Provider.of<ArticlesRepo>(context, listen: false);      
    index==0 ? articlesHolder.onlyFav=false : articlesHolder.onlyFav=true;
    setState(() {
      _currentIndex = index;
    });
  }

  void _searchPressed() {
    var articlesHolder = Provider.of<ArticlesRepo>(context, listen: false);        
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search),
            hintText: 'Search...'
          ),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text( 'HotNews' );
        filteredNames = articlesHolder.getArticles('all');
        _filter.clear();
      }
    });
  }  

  @override
  Widget build(BuildContext context) {
      
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
        centerTitle: true,
        leading: new IconButton(
            icon: _searchIcon,
            onPressed: _searchPressed,
      ),        
        bottom: TabBar(
          indicatorWeight: 2,
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      
      //drawer:MainDrawer(),
      
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          return Center(
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: _searchText == '' ? listNewCreator(tab.text.toLowerCase()) : listSearchCreator('all'),
            ),
          );
        }).toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
              title: Text("News"), icon: Icon(Icons.new_releases)),
          BottomNavigationBarItem(
              title: Text("Favourites"), icon: Icon(Icons.label_important)),
        ],
      ),
    );
  }

  /// method used to build the search result
  Widget listSearchCreator(var tabcategory) {
    
    return Consumer<ArticlesRepo>(builder: (context, news, child) {
      List<Article> localSearch = news.getArticles(tabcategory, searchText: _searchText);
      if ( LocalHistoryEntry != null) {
        return ListView.builder(
          itemCount: localSearch.length,
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
                                  localSearch[position])));
                    },
                    child: localSearch[position]
                            .urlToImage != null ? Image(
                        image: NetworkImage(
                            localSearch[position]
                            .urlToImage)) : Text(''),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                            localSearch[position].title,
                            style:
                                TextStyle(fontSize: 16, color: Colors.black45)),
                      ),
                      GestureDetector(
                        onTap: () {
                          news.manageFavMap(localSearch[position]);
                        },
                        child: manageFavIcons(
                            news, localSearch[position]),
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
                          news.manageFavMap(news.getArticles(tabcategory)[position]);
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


  Widget manageFavIcons(ArticlesRepo mynews, Article current) {
    
    if (mynews.favArticlesMap.containsKey(current.url))
      return  Icon(Icons.favorite,color: Colors.red,);
    else
      return  Icon(Icons.favorite_border);


    
  }
}
