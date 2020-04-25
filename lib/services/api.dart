import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:hotnews/models/article.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hotnews/models/articlesRepo.dart';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';

const APIKEY = '116645e222bc47e2ada73c969299197d';
const HOSTNAME = 'https://newsapi.org/v2/';
const TOP_HEADLINES = 'top-headlines';

///
class Api {
  final Dio dio = Dio();
  final DioCacheManager dioCache =
      DioCacheManager(CacheConfig(baseUrl: HOSTNAME));

  Api() {
    dio.options.connectTimeout = 4000;
    dio.options.baseUrl=HOSTNAME;
    dio.transformer = FlutterTransformer();
    dio.interceptors.add(dioCache.interceptor);
    
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        if (options.extra.isNotEmpty) {
          options.queryParameters.addAll(options.extra);
        }
        LinkedHashMap<String, dynamic> params = options.queryParameters;
        params['apiKey'] = APIKEY;
        params['country'] = 'it';
        options.queryParameters = params;
      },
      onResponse: (Response response) async {
        return response;
      },
      onError: (DioError e) async {
        return e;
      }));
  }
  Future<void> fetchArticles({@required BuildContext context, String category}) async {
    
    var articlesHolder = Provider.of<ArticlesRepo>(context, listen: false);
    
    dio.options.extra = {"category": category};
    final response = await dio.get(TOP_HEADLINES);
    
    print(response);

    List<Article> news = response.data['articles']
        .map<Article>((json) => Article.fromJson(json))
        .toList();
     articlesHolder.addToArticlesMap(category, news);
    if (articlesHolder.favArticlesMap.length == 0) {
      articlesHolder.loadFavouritesMap();
    }
  }

  Future<List<Article>> getHeadlines() async {
    var client = http.Client();
    final response = await client.get(_buildUrl(TOP_HEADLINES));
    return await compute(_parseArticle, response.body);
  }

  static List<Article> _parseArticle(String responseBody) {
    final parsed = json.decode(responseBody);
    return parsed['articles']
        .map<Article>((json) => Article.fromJson(json))
        .toList();
  }

  String _buildUrl(String endpoint, {String category}) {
    String url = '$HOSTNAME$endpoint?country=it';
    if (category != null) {
      url += '&category=$category';
    }
    log('preparade url $url&apiKey=$APIKEY');
    return '$url&apiKey=$APIKEY';
  }
}
