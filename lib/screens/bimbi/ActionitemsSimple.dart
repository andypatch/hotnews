import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotnews/screens/bimbi/layoutSizeChangeNotification.dart';

 
 
const ITEMS_WIDTH = 60.0;
 
class ActionItemsSimple extends Object {
  ActionItemsSimple(
      {@required this.icon,
      @required this.onPress,
      this.backgroudColor: Colors.grey}) {
    assert(icon != null);
    assert(onPress != null);
  }
 
  final Widget icon;
  final VoidCallback onPress;
  final Color backgroudColor;
}
 
class OnSlideSimple extends StatefulWidget {
  OnSlideSimple(
      {Key key,
      @required this.items,
      @required this.child,
      this.backgroundColor: Colors.white})
      : super(key: key) {
    assert(items.length <= 6);
  }
 
  final List<ActionItemsSimple> items;
  final Widget child;
  final Color backgroundColor;
 
  @override
  State<StatefulWidget> createState() {
    return _OnSlideSimpleState();
  }
}
 
class _OnSlideSimpleState extends State<OnSlideSimple> {
  bool isOpen = false;
  
  ScrollController controller = ScrollController();
  Size childSize;
 
  @override
  Widget build(BuildContext context) {
    if (childSize == null) {
      return NotificationListener(
        child: LayoutSizeChangeNotifier(
          child: widget.child,
        ),
        onNotification: (LayoutSizeChangeNotification notification) {
          childSize = notification.newSize;
          print(notification.newSize);
          scheduleMicrotask(() {
            setState(() {});
          });
          return;
        },
      );
    }
 

    List<Widget> scrollWidgets = <Widget>[
      Container(
        width: childSize.width,
        child: widget.child,
      ),
    ];
    List<Widget> under = <Widget>[];
 
    for (ActionItemsSimple item in widget.items) {
      under.add(Expanded(
          child: Container(
        alignment: Alignment.center,
        color: item.backgroudColor,
        width: ITEMS_WIDTH,
        child: item.icon,
      )));
 
      scrollWidgets.add(InkWell(
          child: Container(
            color: Colors.transparent,
            alignment: Alignment.center,
            width: 30.0,
            height: childSize.height,
          ),
          onTap: () {
            scheduleMicrotask(() {
              controller.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.easeInCirc);
            });
            item.onPress();
          }));
    }
 
    Widget scrollview = NotificationListener(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: scrollWidgets,
        controller: controller,
      ),
      onNotification: _handleNotification,
    );
 
    return Stack(
      children: <Widget>[
        Container(
          width: childSize.width,
          height: childSize.height - 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: under,
          ),
        ),
        Positioned(
          child: scrollview,
          left: 0.0,
          bottom: 0.0,
          right: 0.0,
          top: 0.0,
        )
      ],
    );
  }
  bool _handleNotification(dynamic notification) {
      if (notification is ScrollEndNotification) {
        if (notification.metrics.pixels >= (ITEMS_WIDTH) / 2 &&
            notification.metrics.pixels < ITEMS_WIDTH) {
          scheduleMicrotask(() {
            controller.animateTo(10.0,
                duration: Duration(milliseconds: 600), curve: Curves.decelerate);
          });
        } else if (notification.metrics.pixels > 0.0 &&
            notification.metrics.pixels < (ITEMS_WIDTH) / 2) {
          scheduleMicrotask(() {
            controller.animateTo(0.0,
                duration: Duration(milliseconds: 600), curve: Curves.decelerate);
          });
        }
      }

      return true;
  }
}