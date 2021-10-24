import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:text_to_audio/presentation/screens/gallery_screen.dart';
import 'package:text_to_audio/presentation/screens/launcher_screen.dart';
import 'package:text_to_audio/presentation/screens/login_screen.dart';
import 'package:text_to_audio/presentation/screens/main_screen_archived.dart';
import 'package:text_to_audio/presentation/screens/profile_screen.dart';
import 'package:text_to_audio/presentation/screens/record_screen.dart';
import 'package:text_to_audio/presentation/screens/sign_up_screen.dart';

class AppRoute {
  static const initial_route = '/';
  static const user_info_route = '/info';
  static const record_route = '/record';
  static const review_route = '/review';
  static const submit_route = '/submit';

  static const login_route = '/login';

  static const sign_up_route = '/sign_up';

  AppRoute._();
  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case initial_route:
        return _getLauncherRoute();
      case login_route:
        return _getLoginRoute();
      case sign_up_route:
        return _getSignUpRoute();
      case user_info_route:
        return _getInfoRoute();
      case record_route:
        return _getRecorRoute();
      case review_route:
        return _getGalleryRoute();
    }
    return _defaultRoute();
  }

  static MaterialPageRoute _defaultRoute() {
    return _routeBuilder(
      Scaffold(
        body: Center(
          child: Text('Unknown route'),
        ),
      ),
    );
  }

  static MaterialPageRoute _getInfoRoute() {
    return _routeBuilder(ProfileScreen());
  }

  static MaterialPageRoute _getStartedRoute() {
    return _routeBuilder(MainScreen());
  }

  static MaterialPageRoute _routeBuilder(Widget child) {
    return MaterialPageRoute(builder: (_) => child);
  }

  static Route _getGalleryRoute() {
    return _routeBuilder(GalleryScreen());
  }

  static Route _getRecorRoute() {
    return _routeBuilder(RecordScreen());
  }

  static Route _getLauncherRoute() {
    return _routeBuilder(LauncherScreen());
  }

  static Route _getSignUpRoute() {
    return _routeBuilder(SignUpScreen());
  }

  static Route _getLoginRoute() {
    return _routeBuilder(LoginScreen());
  }
}
