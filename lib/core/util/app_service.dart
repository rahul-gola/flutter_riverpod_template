import 'package:flutter/widgets.dart';

/// App-wide services and shared singletons.
///
/// The keys are cached at first access so their identity is *stable* for the
/// whole app lifetime. Returning a fresh `GlobalKey` from a getter (as a naive
/// implementation does) silently breaks anything that relies on the key being
/// the same instance across rebuilds.
abstract final class AppService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'app-navigator');

  static final GlobalKey<State<StatefulWidget>> appKey =
      GlobalKey<State<StatefulWidget>>(debugLabel: 'app-root');
}
