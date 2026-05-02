import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState get _navigator => navigatorKey.currentState!;

  static Future<T?> pushNamed<T>(String routeName, {Object? arguments}) =>
      _navigator.pushNamed<T>(routeName, arguments: arguments);

  static Future<T?> pushReplacementNamed<T>(String routeName,
          {Object? arguments}) =>
      _navigator.pushReplacementNamed<T, dynamic>(routeName,
          arguments: arguments);

  static Future<T?> pushNamedAndRemoveUntil<T>(
    String routeName, {
    Object? arguments,
    RoutePredicate? predicate,
  }) =>
      _navigator.pushNamedAndRemoveUntil<T>(
        routeName,
        predicate ?? (_) => false,
        arguments: arguments,
      );

  static void pop<T>([T? result]) => _navigator.pop<T>(result);

  static bool canPop() => _navigator.canPop();
}