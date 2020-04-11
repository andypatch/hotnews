
import 'package:flutter/material.dart';
import 'package:hotnews/models/article.dart';
import 'package:hotnews/services/api.dart';
import 'package:provider/provider.dart';

class ArticlesRepo extends ChangeNotifier {
  
  final List<Article> _articles = [];
  final Map<String, List<Article>> _articlesMap = Map();

  ArticlesRepo(){

    Api().getHeadlines().then((value) => articles = value);

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

}

