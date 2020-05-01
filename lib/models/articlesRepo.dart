import 'package:flutter/material.dart';
import 'package:hotnews/models/articlesBloc.dart';

class ArticlesRepo extends InheritedWidget {
  final ArticlesBloc bloc;

  
  ArticlesRepo({this.bloc, Widget child}) : super(child: child);
  static ArticlesRepo of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

