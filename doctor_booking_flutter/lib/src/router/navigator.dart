import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class AppNavigator {
  AppNavigator._(this.context);

  factory AppNavigator.of(BuildContext context) {
    return AppNavigator._(context);
  }

  BuildContext context;

  void push(PageRouteInfo route) {
    context.router.push(route);
  }

  void replace(PageRouteInfo route) {
    context.router.replace(route);
  }

  void replaceAll(List<PageRouteInfo> routes) {
    context.router.replaceAll(routes);
  }

  // use to go back to a previous route
  void pop<T>([T? result]) {
    context.router.pop(result);
  }
}
