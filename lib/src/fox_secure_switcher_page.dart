import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fox_secure_switcher/fox_secure_switcher.dart';

/// RouteObserver for screen widgets.
///
/// It is used to detect transition events of screen widgets.
final RouteObserver<PageRoute<dynamic>> secureAppSwitcherRouteObserver =
    RouteObserver<PageRoute<dynamic>>();

/// Screen mask function class for screen widgets.
///
/// [secureAppSwitcherRouteObserver] must be set to navigatorObservers.
///
/// It has MaterialPageRoute as its parent and wraps
/// the screen widget with [SecureAppSwitcherPage].
/// For iOS, a mask style can be specified.
///
/// ```dart
/// MaterialPageRoute(builder: (context) {
///   return const SecureAppSwitcherPage(
///     style: SecureMaskStyle.blurLight,
///     child: ScreenA(),
///   );
/// })
/// ```
class SecureAppSwitcherPage extends StatefulWidget {
  const SecureAppSwitcherPage({
    required this.child,
    super.key,
    this.style = SecureMaskStyle.light,
  });

  final Widget child;
  final SecureMaskStyle style;

  @override
  SecureAppSwitcherPageState createState() {
    return SecureAppSwitcherPageState();
  }
}

class SecureAppSwitcherPageState extends State<SecureAppSwitcherPage>
    with RouteAware {
  PageRoute<dynamic>? _route;
  Timer? _reactivationTimer;

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute<dynamic> && route != _route) {
      if (_route != null) {
        secureAppSwitcherRouteObserver.unsubscribe(this);
      }
      _route = route;
      secureAppSwitcherRouteObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    _reactivationTimer?.cancel();
    secureAppSwitcherRouteObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    super.didPush();
    SecureAppSwitcher.on(iosStyle: widget.style);
  }

  @override
  void didPop() {
    super.didPop();
    SecureAppSwitcher.off();
  }

  @override
  void didPopNext() {
    super.didPopNext();
    _reactivationTimer?.cancel();
    _reactivationTimer = Timer(const Duration(milliseconds: 500), () {
      if (!mounted) {
        return;
      }
      SecureAppSwitcher.on(iosStyle: widget.style);
    });
  }

  @override
  void didPushNext() {
    super.didPushNext();
    _reactivationTimer?.cancel();
    SecureAppSwitcher.off();
  }
}
