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
  final List<Article> _favArticles = [];
  final Map<String, List<Article>> _articlesMap = Map();
  final HashMap<String, Article> _favArticlesMap = HashMap();

  ArticlesRepo(BuildContext context){
    //Api().getHeadlines().then((value) => articles = value);
    loadFavourites();
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
  List<Article> get favArticles => _favArticles;
  
  
  void addToFavArticles(Article favArt) {
    _favArticles.add(favArt);
    notifyListeners();
  }

  Future<void> loadFavourites() async  {
      final SharedPreferences prefs = await _prefs;
      for (var item in prefs.getKeys()) {
        print(item);
        String myPref=prefs.getString(item);
        Map articleMap = jsonDecode(myPref);
        Article a = Article.fromJson(articleMap);
        addToFavArticles(a);
      }
  }

  void removeFavArticles(Article favSelected) {
     
      _favArticles.removeWhere((item) => item.url == favSelected.url);
      print('item ${favSelected.url} removed!');
      notifyListeners();
  }

}

