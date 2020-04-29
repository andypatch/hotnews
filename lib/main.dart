
import 'package:flutter/material.dart';
import 'package:hotnews/models/articlesBloc.dart';
import 'package:hotnews/models/articlesRepo.dart';
import 'screens/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bloc = ArticlesBloc();
  
  @override
  Widget build(BuildContext context) {
    //  Using MultiProvider is convenient when providing multiple objects.
    return ArticlesRepo(
      bloc: bloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HotNews',
        theme: ThemeData.light(),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHome(),
        },
      ),
    );
  }
}
