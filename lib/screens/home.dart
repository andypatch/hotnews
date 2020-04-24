import 'package:hotnews/models/article.dart';
import 'package:hotnews/models/articlesRepo.dart';
import 'package:flutter/material.dart';
import 'package:hotnews/screens/news_detail.dart';
import 'package:provider/provider.dart';
import 'package:hotnews/services/api.dart';
import 'package:share/share.dart';
import 'package:f_logs/f_logs.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key key}) : super(key: key);
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
  Icon _searchIcon = new Icon(Icons.search);
  List filteredNames = new List();
  
  _MyHomeState(){
    _filter.addListener(() {
        FLog.info(text: 'constructor Home screen');
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
    FLog.info(text: 'iniState Home screen');
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    Api().fetchArticles(context: context, category: 'general');
    Api().fetchArticles(context: context, category: 'health');
    Api().fetchArticles(context: context, category: 'technology');
  }

  Choice _selectedChoice = rightMenuChoises[0]; // The app's "state".


  void _rightMenuSelect(Choice choice) {

    //How to display Snackbar ?
    
    String userMessage='';
    switch (rightMenuChoises.indexOf(choice)) {
      case 0:
        {
          Provider.of<ArticlesRepo>(context, listen: false).cleanPrefs();
          userMessage="Favourites deleted!";
        }
        break;
      case 1:
        {
          FLog.exportLogs();
          userMessage="Logs exported succesfully!";
        }
        break;
      default:
    }// Causes the app to rebuild with the new _selectedChoice.
    final snackBar = new SnackBar(
        content: new Text(userMessage),
        duration: new Duration(seconds: 3),
        backgroundColor: Colors.green,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    setState(() {
      _selectedChoice = choice;
    });
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
          style: TextStyle(color: Colors.white),
          scrollPadding: EdgeInsets.all(4),
          controller: _filter,
          decoration: new InputDecoration(
            fillColor: Colors.white,
            prefixIcon: new Icon(Icons.search),
            hintText: ' Search...',
            suffixIcon: IconButton(
                onPressed: () => _filter.clear(),
                icon: Icon(Icons.clear),
             ),            
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
      key: _scaffoldKey,
      appBar: AppBar(
        title: _appBarTitle,
        centerTitle: true,
        leading: new IconButton(
            icon: _searchIcon,
            onPressed: _searchPressed,
            ),        
        actions: <Widget>[
              PopupMenuButton<Choice>(
                onSelected: _rightMenuSelect,
                itemBuilder: (BuildContext context) {
                  return rightMenuChoises.map((Choice choice) {
                    return PopupMenuItem<Choice>(
                      value: choice,
                      child: Text(choice.title),
                    );
                }).toList();
              },
            ),
        ],
        bottom: this._searchIcon.icon == Icons.search ? TabBar(
          indicatorWeight: 2,
          controller: _tabController,
          tabs:  myTabs,
        ) : null,
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
      if ( localSearch.length != 0) {
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
        return Text('No items found!');
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
                     SizedBox(width: 15,), 
                      Builder(
                        builder: (BuildContext context) {
                          return 
                            GestureDetector(
                              onTap: () {
                                final RenderBox box = context.findRenderObject();
                                Share.share(news.getArticles(tabcategory)[position].url,
                                    subject: 'News sharing',
                                    sharePositionOrigin:
                                        box.localToGlobal(Offset.zero) &
                                            box.size);
                              },
                              child: Icon( Icons.share),
                            );
                        },
                      ),                     
                      SizedBox(width: 15,),
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

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> rightMenuChoises = const <Choice>[
  const Choice(title: 'Clean Favourites', icon: Icons.delete),
  const Choice(title: 'Export Logs', icon: Icons.save),
];