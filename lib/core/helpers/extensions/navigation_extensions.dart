import 'package:flutter/material.dart';

extension Navigation on BuildContext {
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> push(Widget widget) {
    return Navigator.of(this).push(MaterialPageRoute(
      builder: (context) => widget,
    ));
  }

  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplacement(Widget widget) {
    return Navigator.of(this).pushReplacement(
      MaterialPageRoute(
        builder: (_) => widget,
      ),
    );
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName,
      {Object? arguments, required RoutePredicate predicate}) {
    return Navigator.of(this)
        .pushNamedAndRemoveUntil(routeName, predicate, arguments: arguments);
  }

  Future<dynamic> pushAndRemoveUntil(Widget widget, RoutePredicate predicate) {
    return Navigator.of(this).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => widget,
        ),
        predicate);
  }

  void pop() => Navigator.of(this).pop();
}
