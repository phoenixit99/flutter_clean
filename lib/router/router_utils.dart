enum AppRoute { splashscreen, login, home, settings, profile, bottomBar }

class RouteUtils {
  static String getRoute(AppRoute route) {
    switch (route) {
      case AppRoute.splashscreen:
        return '/';
      case AppRoute.login:
        return '/login';
      case AppRoute.home:
        return '/home';
      case AppRoute.settings:
        return '/settings';
      case AppRoute.profile:
        return '/profile';
      case AppRoute.bottomBar:
        return '/bottomBar';
      default:
        return '/';
    }
  }
}
