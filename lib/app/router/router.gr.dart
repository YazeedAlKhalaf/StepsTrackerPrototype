// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:steps_tracker/ui/views/home/home_view.dart' as _i3;
import 'package:steps_tracker/ui/views/leaderboard/leaderboard_view.dart'
    as _i6;
import 'package:steps_tracker/ui/views/login/login_view.dart' as _i5;
import 'package:steps_tracker/ui/views/main/main_view.dart' as _i7;
import 'package:steps_tracker/ui/views/register/register_view.dart' as _i4;
import 'package:steps_tracker/ui/views/startup/startup_view.dart' as _i2;

class StepsTrackerRouter extends _i1.RootStackRouter {
  StepsTrackerRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    StartupRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i2.StartupView());
    },
    HomeRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i3.HomeView());
    },
    RegisterRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i4.RegisterView());
    },
    LoginRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i5.LoginView());
    },
    LeaderboardRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i6.LeaderboardView());
    },
    MainRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i7.MainView());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(StartupRoute.name, path: '/'),
        _i1.RouteConfig(HomeRoute.name, path: '/home-view'),
        _i1.RouteConfig(RegisterRoute.name, path: '/register-view'),
        _i1.RouteConfig(LoginRoute.name, path: '/login-view'),
        _i1.RouteConfig(LeaderboardRoute.name, path: '/leaderboard-view'),
        _i1.RouteConfig(MainRoute.name, path: '/main-view')
      ];
}

class StartupRoute extends _i1.PageRouteInfo {
  const StartupRoute() : super(name, path: '/');

  static const String name = 'StartupRoute';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/home-view');

  static const String name = 'HomeRoute';
}

class RegisterRoute extends _i1.PageRouteInfo {
  const RegisterRoute() : super(name, path: '/register-view');

  static const String name = 'RegisterRoute';
}

class LoginRoute extends _i1.PageRouteInfo {
  const LoginRoute() : super(name, path: '/login-view');

  static const String name = 'LoginRoute';
}

class LeaderboardRoute extends _i1.PageRouteInfo {
  const LeaderboardRoute() : super(name, path: '/leaderboard-view');

  static const String name = 'LeaderboardRoute';
}

class MainRoute extends _i1.PageRouteInfo {
  const MainRoute() : super(name, path: '/main-view');

  static const String name = 'MainRoute';
}
