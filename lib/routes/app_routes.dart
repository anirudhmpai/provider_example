import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/provider/connectivity.dart';
import 'package:provider_example/screens/consumer.dart';
import 'package:provider_example/screens/home.dart';
import 'package:provider_example/screens/jokes/jokes_categories.dart';
import 'package:provider_example/screens/no_internet.dart';

class AppRoutes {
  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (context) {
        final isOnline = Provider.of<ConnectivityProvider>(context).isOnline;
        if (isOnline) {
          switch (routeSettings.name) {
            case Paths.initial:
              return const HomeScreen();
            case Paths.home:
              return const HomeScreen();
            case Paths.consumer:
              return const ConsumerScreen();
            case Paths.noInternet:
              return const NoInternetScreen();
            case Paths.jokesCategories:
              return const JokesCategoriesScreen();
            default:
              return const HomeScreen();
          }
        } else {
          return const NoInternetScreen();
        }
      },
    );
  }
}

abstract class Paths {
  Paths._();
  static const initial = '/';
  static const home = '/home';
  static const consumer = '/consumer';
  static const noInternet = '/no-internet';
  static const jokesCategories = '/jokes-categories';
}
