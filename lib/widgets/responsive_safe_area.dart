import 'package:flutter/material.dart';
import 'dart:io';

typedef ResponsiveBuilder = Widget Function(BuildContext context);

class ResponsiveSafeArea extends StatelessWidget {

  const ResponsiveSafeArea({
    @required ResponsiveBuilder builder,
    Key key,
  }) : responsiveBuilder = builder, super(key: key);

  final ResponsiveBuilder responsiveBuilder;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
          child: responsiveBuilder(context)
      ),
    );
  }
}