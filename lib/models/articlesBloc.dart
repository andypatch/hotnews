import 'dart:async';
import 'package:hotnews/models/article.dart';
import 'package:hotnews/services/db_repo.dart';
import 'package:hotnews/services/api.dart';


class ArticlesBloc {
  
  ArticlesBlocState _currentState;
  
  final DbRepository _dbRepository = DbRepository();
  final Map<String, List<Article>> _articlesMap = Map();
  final Map<String, List<Article>> _articlesMapSafeCopy = Map();

  bool _onlyFav=false;

  StreamSubscription<Article> _fetchArticlesSub;

  final _articlesController = StreamController<ArticlesBlocState>.broadcast();
  Stream<ArticlesBlocState> get articlesStream => _articlesController.stream;

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
      /// TODO:  implemnents
    }
    else
    {

    }
    _articlesController.add(_currentState);
  }

  void cleanPrefs(){
      
  }

}
class ArticlesBlocState {
  bool loading;
  Map<String, List<Article>> articlesMap = Map();

  ArticlesBlocState(this.loading, this.articlesMap);

  ArticlesBlocState.empty() {
    loading = false;
    articlesMap = Map();
  }  
  
}

