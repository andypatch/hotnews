import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hotnews/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hotnews/models/articlesRepo.dart';

const TOKEN = '116645e222bc47e2ada73c969299197d';
const endpoint = 'https://newsapi.org/v2/';
const TOP_HEADLINES = 'top-headlines';
const API = '';

class Api {
  Future<void> fetchArticles(
      {@required BuildContext context, String category}) async {
    var articlesHolder = Provider.of<ArticlesRepo>(context, listen: false);
    var client = http.Client();
    final response =
        await client.get(_buildUrl(endpoint + TOP_HEADLINES, category: category));
    List<Article> news = await compute(_parseArticle, response.body);
    articlesHolder.addToArticlesMap(category, news);
  }

  Future<List<Article>> getHeadlines() async {
    var client = http.Client();
    final response = await client.get(_buildUrl(endpoint + TOP_HEADLINES));
    return await compute(_parseArticle, response.body);
  }

  static List<Article> _parseArticle(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed['articles']
        .map<Article>((json) => Article.fromJson(json))
        .toList();
  }

  String _buildUrl(String endpoint, {String category}) {
    String url = '$API$endpoint?country=it';
    if (category != null) {
      url += '&category=$category';
    }
    return '$url&apiKey=$TOKEN';
  }
}

// class MainNews {

//     static Future<List> getArticles() async {
//         String completedUrl =   apiUrl + methodUrl +  '&apiKey=' +apiKey;
//         final http.Response response = await http.get(completedUrl);
//         debugPrint(response.body);
//         if (response.statusCode != 200) {
//           throw Exception('Failed to load jobs from API');
//         }
//         else
//         {
//           final parsed =json.decode(response.body);
//           var a = parsed['articles'].map((element) => new Article.fromJson(element)).toList();
//           return a;
//         }
//       }
// }
