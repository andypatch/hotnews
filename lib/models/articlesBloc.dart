import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
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

  final _articlesController = StreamController<ArticlesBlocState>.broadcast();
  Stream<ArticlesBlocState> get articlesStream => _articlesController.stream;


  ArticlesBloc(){
    _currentState = ArticlesBlocState.empty();
  }

  prefInit(){
    _prefs = SharedPreferences.getInstance();    
    loadFavouritesMap().then((bool value) { print('fav loaded!');});
    _currentState.favArticlesMap.addAll(_favArticlesMap);
  }

  ArticlesBlocState getCurrentState() {
    return _currentState;
  }
 
  bool get onlyFav => _onlyFav;
  set onlyFav(bool value) {
    _onlyFav = value;
  }

  fetchArticles(String category) {
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
    });
  }

  
  searchText (String textToSearch){
    
    _articlesMapSafeCopy.clear();
    _articlesMapSafeCopy.addAll(_articlesMap);

    _currentState.articlesMap.forEach((k,v)
    { 
      List<Article> fav = [];
      for(var i = 0; i < v.length; i++){
        if (v[i].description.contains(textToSearch)){
            fav.add(v[i]);
        }
      } 
      _currentState.articlesMap[k] = fav;       
    });
    _articlesController.add(_currentState);
  }

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

  // List<Article> getArticles(String category, {searchText = ''}){
  //    if (!_onlyFav){
  //      if (category=='all')
  //      {
  //        if (searchText=='')
  //        {
  //           return [_articlesMap['general'], _articlesMap['health'], _articlesMap['technology']].expand((x) => x).toList();
  //        }
  //        else // filtro su searhc string
  //        {
  //           List<Article> allItems = [_articlesMap['general'], _articlesMap['health'], _articlesMap['technology']].expand((x) => x).toList();
  //           List<Article> founds=[];
  //           for (int i = 0; i < allItems.length; i++) {
  //             if (allItems[i].title.toLowerCase().contains(searchText.toLowerCase())) {
  //               founds.add(allItems[i]);
  //             }
  //           }
  //           return founds;
  //        }
  //      }
  //      else
  //      {
  //         return _articlesMap[category];
  //      }

  //    }
  //    else
  //    {
  //       final List<Article> tempFavList = [];
  //       _favArticlesMap.forEach((k,v) { tempFavList.add(v); });
  //       return tempFavList;
  //    }
  // }

  HashMap get favArticlesMap => _favArticlesMap;
  
  manageFavMap(Article favObj){
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

  Future<bool> loadFavouritesMap() async  {
      final SharedPreferences prefs = await _prefs;
      for (var item in prefs.getKeys()) {
        print(item);
        Map articleMap = jsonDecode(prefs.getString(item));
        _favArticlesMap[item] =  Article.fromJson(articleMap);
      }
      return true;
  }  

  void preferencesUpdate(Article favObj) async{
    _prefs ?? prefInit();
    final SharedPreferences prefs = await _prefs;
    prefs.containsKey(favObj.url) ? prefs.remove(favObj.url) : prefs.setString(favObj.url, json.encode(favObj));
  }    

  void cleanPrefs() async{
      final SharedPreferences prefs = await _prefs;
      prefs.clear().then((value) {
        _favArticlesMap.clear();
        });
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

