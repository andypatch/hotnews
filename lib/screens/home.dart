import 'package:hive/hive.dart';
import 'package:hotnews/components/news_listview_item.dart';
import 'package:hotnews/models/article.dart';
import 'package:hotnews/models/articlesBloc.dart';
import 'package:hotnews/models/articlesRepo.dart';
import 'package:flutter/material.dart';
import 'package:f_logs/f_logs.dart';

import '../main.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key key}) : super(key: key);
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _appBarTitle = new Text('HotNews');
  final TextEditingController _filter = new TextEditingController();

  Box<Article> favoriteBox;


  TabController _tabController;
  Icon _searchIcon = new Icon(Icons.search);
  List filteredNames = new List();
  bool _firstTimeLoad = true;

  _MyHomeState() {
    favoriteBox = Hive.box(NewsBox);
    _filter.addListener(() {
      var bloc = ArticlesRepo.of(context).bloc;
      FLog.info(text: 'constructor Home screen');
      bloc.searchText(_filter.text.toLowerCase());
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: categories.length);
    _tabController.addListener(_handleTabSelection);

    // bloc.fetchArticles();
  }
  void _handleTabSelection() async {
    if (!_tabController.indexIsChanging) {
      final bloc = ArticlesRepo.of(context).bloc;
      bloc.changeCategory(_tabController.index);
    } else
      print("Tab is switching..from active to inactive");
  }

  void _rightMenuSelect(Choice choice) {
    String userMessage = '';
    switch (rightMenuChoises.indexOf(choice)) {
      case 0:
        {
          ArticlesRepo.of(context).bloc.cleanFav();
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
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _searchPressed() {
    var bloc = ArticlesRepo.of(context).bloc;
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
      _firstTimeLoad = false;
      bloc.fetchArticles();
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
        bottom: PreferredSize(
                preferredSize: const Size.fromHeight(42.0),
                child: StreamBuilder<AppScreen>(
                  stream: bloc.actualScreen,
                  builder: (context, AsyncSnapshot<AppScreen> snapshot) {
                    return topBar(snapshot.data);
                  },)
        ),
      ),
      //drawer:MainDrawer(),
      body: StreamBuilder<ArticlesBlocState>(
          initialData: bloc.getCurrentState(),
          stream: bloc.articlesStream,
          builder: _buildList),

      bottomNavigationBar: StreamBuilder<ArticlesBlocState>(
        stream: bloc.articlesStream,
        builder: (context, snapshot) {
          return BottomNavigationBar(
            onTap: (index) => bloc.changeScreen(index),
            currentIndex: bloc.getCurrentState().bottomIndex,
            items: [
              BottomNavigationBarItem(
                  title: Text("News"), icon: Icon(Icons.new_releases)),
              BottomNavigationBarItem(
                  title: Text("Favourites"), icon: Icon(Icons.label_important)),
            ],
          );
        }
      ),
    );
  }

  get categories => CategoriesEnum.values
      .map((e) => Tab(text: categoryName(e).toUpperCase()))
      .toList();

  Widget _buildList(
    BuildContext context, AsyncSnapshot<ArticlesBlocState> snapshot) {
    if (snapshot.data.loading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return TabBarView(
      controller: _tabController,
      /// TODO: spiegare perchè senza <Widget> non funziona un cazzo
      children: categories.map<Widget>((Tab tab) {
        return Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: ListView.builder(
              itemCount: snapshot.data.articlesMap[tab.text.toLowerCase()] ==
                      null
                  ? 0
                  : snapshot.data.articlesMap[tab.text.toLowerCase()].length,
              itemBuilder: (context, position) => NewsItem(
                  snapshot.data.articlesMap[tab.text.toLowerCase()][position]),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget topBar(AppScreen appScreen) {
      switch (appScreen) {
        case AppScreen.favorites:
          return Container();
        case AppScreen.main:
        default:
          return TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            tabs: categories,
            controller: _tabController,
          );
      }
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
