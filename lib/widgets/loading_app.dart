import 'package:adan/widgets/responsive_safe_area.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class LoadingApp extends StatefulWidget {
  @override
  _LoadingAppState createState() => _LoadingAppState();
}

class _LoadingAppState extends State<LoadingApp> with SingleTickerProviderStateMixin {

  AnimationController animController;
  Animation<double> animation;

  @override
  void initState() {
    _initAnimation();
    super.initState();
  }

  void _initAnimation() {
    try {
      animController = AnimationController(
          duration: Duration(seconds: 2),
          vsync: this,
      );
      final curvedAnimation = CurvedAnimation(
        parent: animController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      );

      animation = Tween<double>(
          begin: 0, end: 2 * math.pi).animate(curvedAnimation)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            animController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            animController.forward();
          }}
        );
      animController.forward();
    }catch(e) {
      print("error, _initAnimation: $e");
      animController.dispose();
    }
  }

  @override
  void dispose() {
    animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: FadeTransition(
            opacity: animation,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                'assets/logo_inoser.png',
                // color: Colors.pink,
                width: 80,
              ),
              // child: Image.asset(ImageHelper.LOGO),
            ),
          ),
        ),
      ),
    );
  }
}
