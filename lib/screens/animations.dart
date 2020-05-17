import 'package:flutter/material.dart';

class AnimationsTest extends StatefulWidget {
  @override
  _AnimationsTestState createState() => _AnimationsTestState();
}

class _AnimationsTestState extends State<AnimationsTest>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    animation = Tween(begin: -0.25, end: 0.0).animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn))
    ..addStatusListener((status) {
      if (status==AnimationStatus.completed)
        _controller.reverse();
      else if (status==AnimationStatus.dismissed)
        _controller.forward();
    });
  }
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    _controller.forward();

    return SafeArea(
          child: Scaffold(
        body: Container(
          color: Colors.blue[300],
          child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return Transform(
                  transform: Matrix4.translationValues(animation.value * width, animation.value * height, 0.0),
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          pressed = !pressed;
                        });
                      },
                      child: Center(
                      child: Container(
                          width: pressed ? 100:300, height: pressed ? 100:300, color: Colors.cyanAccent),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
