import 'dart:collection';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:hotnews/bimbi/models/b_customer.dart';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';

const APIKEY = '116645e222bc47e2ada73c969299197d';
const HOSTNAME = 'http://www.mocky.io/v2/';
const TOP_HEADLINES = '5ecd463c320000820023687c';

///
class BApi {
  final Dio dio = Dio();
  final DioCacheManager dioCache =
      DioCacheManager(
        CacheConfig(
          baseUrl: HOSTNAME, defaultMaxAge: new Duration(hours: 1)
        )
      );

  BApi() {
    dio.options.connectTimeout = 4000;
    dio.options.baseUrl=HOSTNAME;
    dio.transformer = FlutterTransformer();
    dio.interceptors.add(dioCache.interceptor);
    
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (RequestOptions options) async {
        // if (options.extra.isNotEmpty) {
        //   options.queryParameters.addAll(options.extra);
        // }
        // LinkedHashMap<String, dynamic> params = options.queryParameters;
        // params['apiKey'] = APIKEY;
        // params['country'] = 'it';
        // options.queryParameters = params;
      },
      onResponse: (Response response) async {
        return response;
      },
      onError: (DioError e) async {
        return e;
      }));
  }
  Future<void> fetchCustomers(String category) async {

    ///dio.options.extra = {"category": category};
    final response = await dio.get(TOP_HEADLINES);
    
    print(response);

    return response.data['customers']
        .map<Customer>((json) => Customer.fromJson(json))
        .toList();
  }

}
