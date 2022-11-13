import 'package:flutter/cupertino.dart';

class AppRouter {
  AppRouter._();
  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static goAndRemove(String screenName) {
    navigationKey.currentState!
        .pushNamedAndRemoveUntil(screenName, (route) => false);
  }

  static goTo(String screenName) {
    navigationKey.currentState!.pushNamed(screenName);
  }
  static back() {
    navigationKey.currentState!.pop();
  }
}
