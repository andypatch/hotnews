import 'dart:async';
import 'package:hive/hive.dart';
import 'package:hotnews/models/article.dart';
import 'package:hotnews/services/db_repo.dart';
import 'package:hotnews/services/api.dart';

import '../main.dart';


enum AppScreen { main, favorites }

enum CategoriesEnum {
  general,
  business,
  entertainment,
  health,
  science,
  sports,
  technology
}

// interessante
String categoryName(CategoriesEnum category) =>
    category
        .toString()
        .split('.')
        .last;


class ArticlesBloc {
  
  ArticlesBlocState _currentState;
  
  final DbRepository _dbRepository = DbRepository();
  final Map<String, List<Article>> _articlesMap = Map();
  final Map<String, List<Article>> _articlesMapSafeCopy = Map();

  CategoriesEnum _actualCategory = CategoriesEnum.general;
  AppScreen _actualScreen = AppScreen.main;

  StreamSubscription<Article> _fetchArticlesSub;

  final _articlesController = StreamController<ArticlesBlocState>.broadcast();
  final _screenController = StreamController<CategoriesEnum>.broadcast();
  final _actualScreenController = StreamController<AppScreen>.broadcast();

  Stream<CategoriesEnum> get actualCategory => _screenController.stream;
  Stream<AppScreen> get actualScreen => _actualScreenController.stream;
  Stream<ArticlesBlocState> get articlesStream => _articlesController.stream;

  void changeScreen(int index) {
    _currentState.bottomIndex = index;
    _actualScreen = AppScreen.values[index];
    _actualScreenController.sink.add(_actualScreen);
    _manageArticles();
  }

  void _manageArticles(){
    if (AppScreen.favorites == _actualScreen) {
          _currentState.articlesMap[categoryName(_actualCategory)] = _dbRepository.getArticles();
          _currentState.loading = false;
          _articlesController.add(_currentState);      
    }
    else {
      fetchArticles();
    }      
  }

  void changeCategory (int index){
    _actualCategory = CategoriesEnum.values[index];
    //_articles.sink.add(null); //Clear news
    _screenController.sink.add(_actualCategory);
    fetchArticles(); 
  }

  ArticlesBloc(){
    _currentState = ArticlesBlocState.empty();
    _dbRepository.watch().forEach((element){
      print ("Update" + element.toString());
    });
  }
  /// current state getter
  ArticlesBlocState getCurrentState() {
    return _currentState;
  }
 

  String categoryName(CategoriesEnum category) =>
    category
        .toString()
        .split('.')
        .last;

  void fetchArticles() {
    _fetchArticlesSub?.cancel();
    _currentState.loading = true;
    _articlesController.add(_currentState);

    Api().fetchArticles(categoryName(_actualCategory))
        .asStream()
        .listen((dynamic result) {
          if (result is List<Article>) {
            _currentState.articlesMap[categoryName(_actualCategory)] = result;
          }
          _currentState.loading = false;
          _articlesController.add(_currentState);
          _articlesMap.addAll(_currentState.articlesMap);
    });
  }

  void favouritesChange(){
    _articlesController.add(_currentState);
  }

  void startSearch() {
    _articlesMapSafeCopy.clear();
    _articlesMapSafeCopy.addAll(_articlesMap);    
  }

  void stopSearch() {
    _articlesMap.clear();
    _articlesMap.addAll(_articlesMapSafeCopy);    
    _currentState.articlesMap.clear();
    _currentState.articlesMap.addAll(_articlesMap);
    _articlesController.add(_currentState);
  }  
  
  /// serach text in the articleMap
  /// seems fast
  void searchText (String textToSearch){
    _articlesMap.clear();
    _articlesMap.addAll(_articlesMapSafeCopy);  

    _articlesMap.forEach((k,v)
    { 
      List<Article> fav = [];
      for(var i = 0; i < v.length; i++){
        String actualDescription = v[i].description ?? '';
        String actualContent = v[i].content ?? '';
        if (actualDescription.toLowerCase().contains(textToSearch) || actualContent.toLowerCase().contains(textToSearch)){
            fav.add(v[i]);
        }
      } 
      _currentState.articlesMap[k] = fav;       
    });
    _articlesController.add(_currentState);
  }

  dispose(){
    _screenController?.close();
    _actualScreenController?.close();
    _articlesController?.close();
  }

  void cleanFav() {
    Box<Article> favoriteBox;
    favoriteBox = Hive.box(NewsBox);
    favoriteBox.clear();
     _articlesController.add(_currentState);
  }

}
class ArticlesBlocState {
  int bottomIndex=0;
  bool loading;
  Map<String, List<Article>> articlesMap = Map();

  ArticlesBlocState(this.loading, this.articlesMap);

  ArticlesBlocState.empty() {
    loading = false;
    articlesMap = Map();
  }  
  
}

