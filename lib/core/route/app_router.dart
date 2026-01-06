import 'package:flutter/material.dart';
import 'package:flutter_riverpod_template/core/di/di.dart';
import 'package:flutter_riverpod_template/src/home/home_screen.dart';
import 'package:flutter_riverpod_template/src/splash_screen/splash_screen.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => HomeScreen(homeViewModelProvider),
      );
    default:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
  }
}
