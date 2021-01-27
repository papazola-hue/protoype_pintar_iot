import 'package:flutter/material.dart';

class Nav {
  static Future<dynamic> push(context, var route) {
    return Navigator.of(context).push(PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, animationTime, child) {
          animation =
              CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
          return ScaleTransition(
            alignment: Alignment.center,
            scale: animation,
            child: child,
          );
        },
        pageBuilder: (context, animation, animationTime) {
          return route;
        }));
  }
}
