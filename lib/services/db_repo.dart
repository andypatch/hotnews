import 'package:hive/hive.dart';
import 'package:hotnews/main.dart';
import 'package:hotnews/models/article.dart';

class DbRepository {
  Box<Article> favouritesNews = Hive.box(NewsBox);

  void addArticle(Article article) => favouritesNews.put(article.id, article);

  List<Article> getArticles() => favouritesNews.values.toList();

  watch() => favouritesNews.watch();
}
