import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:hotnews/models/article.dart';
import 'package:hotnews/services/api.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ArticlesRepo extends ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  
  final List<Article> _articles = [];
  final Map<String, List<Article>> _articlesMap = Map();
  final HashMap<String, Article> _favArticlesMap = HashMap();

  ArticlesRepo(BuildContext context){
    //Api().getHeadlines().then((value) => articles = value);
    loadFavouritesMap();
  }

  set articles(List<Article> news) {
    assert(news != null);

    _articles.addAll(news);
    notifyListeners();
  }
  
  void addToArticlesMap(String key, List<Article> news) {
    assert(news != null);
    _articlesMap[key] = news;
    notifyListeners();
  }
  
  List<Article> getArticles(String category) => _articlesMap[category];
  List<Article> get articles => _articles;
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
    notifyListeners();
    preferencesUpdate(favObj);
  }

  // void addToFavArticles(Article favArt) {
  //   _favArticles.add(favArt);
  //   notifyListeners();
  // }

  // Future<void> loadFavourites() async  {
  //     final SharedPreferences prefs = await _prefs;
  //     for (var item in prefs.getKeys()) {
  //       print(item);
  //       String myPref=prefs.getString(item);
  //       Map articleMap = jsonDecode(myPref);
  //       Article a = Article.fromJson(articleMap);
  //       addToFavArticles(a);
  //     }
  // }

  Future<void> loadFavouritesMap() async  {
      final SharedPreferences prefs = await _prefs;
      for (var item in prefs.getKeys()) {
        print(item);
        Map articleMap = jsonDecode(prefs.getString(item));
        _favArticlesMap[item] =  Article.fromJson(articleMap);
      }
  }  

  // void removeFavArticles(Article favSelected) {
  //     _favArticles.removeWhere((item) => item.url == favSelected.url);
  //     print('item ${favSelected.url} removed!');
  //     notifyListeners();
  // }

  void preferencesUpdate(Article favObj) async{
    final SharedPreferences prefs = await _prefs;
    prefs.containsKey(favObj.url) ? prefs.remove(favObj.url) : prefs.setString(favObj.url, json.encode(favObj));
  }    

  void cleanPrefs() async{
      final SharedPreferences prefs = await _prefs;
      prefs.clear().then((value) {
        _favArticlesMap.clear();
        notifyListeners(); 

        });
  }

}

