import 'package:flutter/widgets.dart';

/// Service exposing properties that must be set before services are used.
abstract class AppService {
  const AppService._();

  /// Navigator key to set on the application's Navigator.
  static GlobalKey<NavigatorState>? get navigatorKey =>
      GlobalKey(debugLabel: 'my-app-key');

  /// App root key to set on the application's MaterialApp or WidgetsApp.
  static GlobalKey<State<StatefulWidget>> get appKey =>
      GlobalKey<State<StatefulWidget>>(debugLabel: 'appKey-app-key');
}
