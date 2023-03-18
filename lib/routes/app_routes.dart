import 'package:flutter/material.dart';
import 'package:provider_example/screens/consumer.dart';
import 'package:provider_example/screens/home.dart';
import 'package:provider_example/screens/no_internet.dart';

class AppRoutes {
  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Paths.initial:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Paths.home:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case Paths.consumer:
        return MaterialPageRoute(builder: (context) => const ConsumerScreen());
      case Paths.noInternet:
        return MaterialPageRoute(
            builder: (context) => const NoInternetScreen());
      default:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
    }
  }
}

abstract class Paths {
  Paths._();
  static const initial = '/';
  static const home = '/home';
  static const consumer = '/consumer';
  static const noInternet = '/no-internet';
}
