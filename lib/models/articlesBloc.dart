import 'dart:async';
import 'dart:collection';
import 'package:hotnews/models/article.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hotnews/services/api.dart';


class ArticlesBloc {
  
  ArticlesBlocState _currentState;
  Future<SharedPreferences> _prefs; 
  
  final Map<String, List<Article>> _articlesMap = Map();
  final Map<String, List<Article>> _articlesMapSafeCopy = Map();
  final HashMap<String, Article> _favArticlesMap = HashMap();
  bool _onlyFav=false;


  StreamSubscription<Article> _fetchArticlesSub;

  HashMap get favArticlesMap => _favArticlesMap;
  final _articlesController = StreamController<ArticlesBlocState>.broadcast();
  Stream<ArticlesBlocState> get articlesStream => _articlesController.stream;

  ArticlesBloc(){
    _currentState = ArticlesBlocState.empty();
  }

  /// Favourites loading and shared pref
  prefInit(){
    _prefs = SharedPreferences.getInstance();    
    loadFavouritesMap().then((bool value) { print('fav loaded!');});
    _currentState.favArticlesMap.addAll(_favArticlesMap);
  }

  /// current state getter
  ArticlesBlocState getCurrentState() {
    return _currentState;
  }
 
  bool get onlyFav => _onlyFav;
  set onlyFav(bool value) {
    _onlyFav = value;
  }

  void fetchArticles(String category) {
    _fetchArticlesSub?.cancel();
    _currentState.loading = true;
    _articlesController.add(_currentState);

    Api().fetchArticles(category)
        .asStream()
        .listen((dynamic result) {
          if (result is List<Article>) {
            _currentState.articlesMap[category] = result;
          }
          _currentState.loading = false;
          _articlesController.add(_currentState);
          _articlesMap.addAll(_currentState.articlesMap);
    });
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

  /// methid switcher beteween standard data and favourites
  switchNewsData (){
    if (this.onlyFav) {
      /// backup corrente 
      _articlesMap.clear();
      _articlesMap.addAll(_currentState.articlesMap);
      _currentState.articlesMap.forEach((k,v)
      { 
        List<Article> fav = [];
        for(var i = 0; i < v.length; i++){
          if (_favArticlesMap.containsKey(v[i].url ?? '0')){
              fav.add(v[i]);
          }
        } 
        _currentState.articlesMap[k] = fav;       
      });
    }
    else
    {
      _currentState.articlesMap.clear();
      _currentState.articlesMap.addAll(_articlesMap);
    }
    _articlesController.add(_currentState);
  }

  /// manage Favourites map
  void manageFavMap(Article favObj){
    if (_favArticlesMap.containsKey(favObj.url))
    {
      _favArticlesMap.remove(favObj.url);
    }
    else
    {
      _favArticlesMap.putIfAbsent(favObj.url, () => favObj);
    }
    preferencesUpdate(favObj);
    _currentState.favArticlesMap = _favArticlesMap;
    _articlesController.add(_currentState);
  }

  /// loading favourites from shared preferences
  /// seems works fine
  Future<bool> loadFavouritesMap() async  {
      final SharedPreferences prefs = await _prefs;
      for (var item in prefs.getKeys()) {
        print(item);
        Map articleMap = jsonDecode(prefs.getString(item));
        _favArticlesMap[item] =  Article.fromJson(articleMap);
      }
      return true;
  }  

  /// favourites managment
  void preferencesUpdate(Article favObj) async{
    _prefs ?? prefInit();
    final SharedPreferences prefs = await _prefs;
    prefs.containsKey(favObj.url) ? prefs.remove(favObj.url) : prefs.setString(favObj.url, json.encode(favObj));
  }    
  
  /// clean preference method
  void cleanPrefs() async{
      final SharedPreferences prefs = await _prefs;
      prefs.clear().then((value) {
        _favArticlesMap.clear();
        });
      _currentState.favArticlesMap.clear();
      _articlesController.add(_currentState);        
      
  }
}
class ArticlesBlocState {
  bool favourites = false;
  bool loading;
  Map<String, List<Article>> articlesMap = Map();
  HashMap<String, Article> favArticlesMap = HashMap();

  ArticlesBlocState(this.loading, this.articlesMap, this.favArticlesMap);

  ArticlesBlocState.empty() {
    loading = false;
    articlesMap = Map();
    favArticlesMap = HashMap();
  }  
  
}

