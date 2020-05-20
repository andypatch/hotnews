
import 'package:flutter/material.dart';
import 'b_customersBloc.dart';

class CustomersRepo extends InheritedWidget {
  final CustomersBloc bloc;

  
  CustomersRepo({this.bloc, Widget child}) : super(child: child);
  static CustomersRepo of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}

