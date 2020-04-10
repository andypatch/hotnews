
import 'package:hotnews/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hotnews/models/articlesRepo.dart';
import 'common/theme.dart';
import 'screens/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //  Using MultiProvider is convenient when providing multiple objects.
    return ChangeNotifierProvider(
      create: (context) => ArticlesRepo(),
      child: MaterialApp(
        title: 'HotNews',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          //'/': (context) => MyLogin(),
          //'/favnews': (context) => MyCatalog(),
          //'/search': (context) => MyCart(),
          '/': (context) => MyHome(),
          //'/favnews': (context) => MyFav(),
          //'/search': (context) => MySearch(),          
        },
      ),
    );
  }
}
