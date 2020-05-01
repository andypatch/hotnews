import 'package:hotnews/models/article.dart';
import 'package:hotnews/models/articlesBloc.dart';
import 'package:hotnews/models/articlesRepo.dart';
import 'package:flutter/material.dart';
import 'package:hotnews/screens/news_detail.dart';
import 'package:share/share.dart';
import 'package:f_logs/f_logs.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key key}) : super(key: key);
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _appBarTitle = new Text('HotNews');
  final TextEditingController _filter = new TextEditingController();

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
  bool _firstTimeLoad = true;

  _MyHomeState() {
      
      _filter.addListener(() {
        var bloc = ArticlesRepo.of(context).bloc;
        FLog.info(text: 'constructor Home screen');
        bloc.searchText(_filter.text.toLowerCase());
      });

  }

  @override
  void initState() {
    FLog.info(text: 'iniState Home screen');
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }


  void _rightMenuSelect(Choice choice) {
    String userMessage = '';
    switch (rightMenuChoises.indexOf(choice)) {
      case 0:
        {
          ArticlesRepo.of(context).bloc.cleanPrefs();
          userMessage = "Favourites deleted!";
        }
        break;
      case 1:
        {
          FLog.exportLogs();
          userMessage = "Logs exported succesfully!";
        }
        break;
      default:
    } // Causes the app to rebuild with the new _selectedChoice.
    final snackBar = new SnackBar(
      content: new Text(userMessage),
      duration: new Duration(seconds: 3),
      backgroundColor: Colors.green,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
    setState(() {
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// view favourites event
  void _onItemTapped(int index) {
    var bloc = ArticlesRepo.of(context).bloc;
    index == 0 ? bloc.onlyFav = false : bloc.onlyFav = true;
    bloc.switchNewsData();
    setState(() {
      _currentIndex = index;
    });
  }

  void _searchPressed() {
    var bloc =  ArticlesRepo.of(context).bloc;
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        bloc.startSearch();
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          style: TextStyle(color: Colors.white),
          scrollPadding: EdgeInsets.all(4),
          controller: _filter,
          decoration: new InputDecoration(
            fillColor: Colors.white,
            prefixIcon: new Icon(Icons.search),
            hintText: ' Search...',
            // suffixIcon: IconButton(
            //   onPressed: () => _filter.clear(),
            //   icon: Icon(Icons.clear),
            // ),
          ),
        );
      } else {
        bloc.stopSearch();
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('HotNews');
        filteredNames = []; //bloc.getArticles('all');
        _filter.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ArticlesBloc bloc = ArticlesRepo.of(context).bloc;
    if (_firstTimeLoad) {
      bloc.prefInit();
      bloc.fetchArticles('general');
      bloc.fetchArticles('health');
      bloc.fetchArticles('technology');
      _firstTimeLoad = false;
    }

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
        bottom: TabBar(
                indicatorWeight: 2,
                controller: _tabController,
                tabs: myTabs,
              )
            ,
      ),
      //drawer:MainDrawer(),
      body: StreamBuilder<ArticlesBlocState>(
              initialData: bloc.getCurrentState(),
              stream: bloc.articlesStream,
              builder: _buildList),
              
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

  Widget _buildList(BuildContext context, AsyncSnapshot<ArticlesBlocState> snapshot) {
    if (snapshot.data.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          return Center(
            child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: ListView.builder(
                  itemCount: snapshot.data.articlesMap[tab.text.toLowerCase()] == null ? 0 : snapshot.data.articlesMap[tab.text.toLowerCase()].length,
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
                                          snapshot.data.articlesMap[tab.text.toLowerCase()][position])));
                            },
                            child:
                                snapshot.data.articlesMap[tab.text.toLowerCase()][position].urlToImage !=
                                        null
                                    ? Image(
                                        image: NetworkImage(snapshot.data
                                            .articlesMap[tab.text.toLowerCase()][position].urlToImage))
                                    : Text('No Picture Available'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                    snapshot.data.articlesMap[tab.text.toLowerCase()][position].title,
                                    style: TextStyle(fontSize: 16, color: Colors.black45)),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Builder(
                                builder: (BuildContext context) {
                                  return GestureDetector(
                                    onTap: () {
                                      final RenderBox box = context.findRenderObject();
                                      Share.share(
                                          snapshot
                                              .data.articlesMap[tab.text.toLowerCase()][position].url,
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
                                  ArticlesRepo.of(context).bloc.manageFavMap(snapshot.data.articlesMap[tab.text.toLowerCase()][position]);
                                  return;
                                },
                                child: manageFavIcons(ArticlesRepo.of(context).bloc.favArticlesMap,
                                    snapshot.data.articlesMap[tab.text.toLowerCase()][position]),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                ),
          );
        }).toList());
  }

  Widget manageFavIcons(Map mynews, Article current) {
    if (mynews.containsKey(current.url))
      return Icon(
        Icons.favorite,
        color: Colors.red,
      );
    else
      return Icon(Icons.favorite_border);
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
