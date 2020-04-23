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
  bool _onlyFav=false;


  ArticlesRepo(BuildContext context){
    loadFavouritesMap().then((bool value) { print('fav loaded!');});
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
  
  bool get onlyFav => _onlyFav;
  set onlyFav(bool value) {
    _onlyFav = value;
    notifyListeners();
  }

  List<Article> getArticles(String category, {searchText = ''}){
     if (!_onlyFav){
       if (category=='all')
       {
         if (searchText=='')
         {
            return [_articlesMap['general'], _articlesMap['health'], _articlesMap['technology']].expand((x) => x).toList();
         }
         else // filtro su searhc string
         {
            List<Article> allItems = [_articlesMap['general'], _articlesMap['health'], _articlesMap['technology']].expand((x) => x).toList();
            List<Article> founds=[];
            for (int i = 0; i < allItems.length; i++) {
              if (allItems[i].title.toLowerCase().contains(searchText.toLowerCase())) {
                founds.add(allItems[i]);
              }
            }
            return founds;
         }
       }
       else
       {
          return _articlesMap[category];
       }

     }
     else
     {
        final List<Article> tempFavList = [];
        _favArticlesMap.forEach((k,v) { tempFavList.add(v); });
        return tempFavList;
     }
  }
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

