// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;
import 'package:steps_tracker/ui/views/account/account_view.dart' as _i9;
import 'package:steps_tracker/ui/views/bmi_calculator/bmi_calculator_view.dart'
    as _i14;
import 'package:steps_tracker/ui/views/edit_profile/edit_profile_view.dart'
    as _i13;
import 'package:steps_tracker/ui/views/history/history_view.dart' as _i11;
import 'package:steps_tracker/ui/views/home/home_view.dart' as _i4;
import 'package:steps_tracker/ui/views/leaderboard/leaderboard_view.dart'
    as _i7;
import 'package:steps_tracker/ui/views/login/login_view.dart' as _i6;
import 'package:steps_tracker/ui/views/main/main_view.dart' as _i8;
import 'package:steps_tracker/ui/views/register/register_view.dart' as _i5;
import 'package:steps_tracker/ui/views/rewards/rewards_view.dart' as _i10;
import 'package:steps_tracker/ui/views/settings/settings_view.dart' as _i12;
import 'package:steps_tracker/ui/views/startup/startup_view.dart' as _i3;

class StepsTrackerRouter extends _i1.RootStackRouter {
  StepsTrackerRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    StartupRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i3.StartupView());
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i4.HomeView(
              key: args.key,
              onSeeLeaderboardPressed: args.onSeeLeaderboardPressed));
    },
    RegisterRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i5.RegisterView());
    },
    LoginRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i6.LoginView());
    },
    LeaderboardRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i7.LeaderboardView());
    },
    MainRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i8.MainView());
    },
    AccountRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i9.AccountView());
    },
    RewardsRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i10.RewardsView());
    },
    HistoryRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i11.HistoryView());
    },
    SettingsRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i12.SettingsView());
    },
    EditProfileRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i13.EditProfileView());
    },
    BmiCalculatorRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i14.BmiCalculatorView());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(StartupRoute.name, path: '/'),
        _i1.RouteConfig(HomeRoute.name, path: '/home-view'),
        _i1.RouteConfig(RegisterRoute.name, path: '/register-view'),
        _i1.RouteConfig(LoginRoute.name, path: '/login-view'),
        _i1.RouteConfig(LeaderboardRoute.name, path: '/leaderboard-view'),
        _i1.RouteConfig(MainRoute.name, path: '/main-view'),
        _i1.RouteConfig(AccountRoute.name, path: '/account-view'),
        _i1.RouteConfig(RewardsRoute.name, path: '/rewards-view'),
        _i1.RouteConfig(HistoryRoute.name, path: '/history-view'),
        _i1.RouteConfig(SettingsRoute.name, path: '/settings-view'),
        _i1.RouteConfig(EditProfileRoute.name, path: '/edit-profile-view'),
        _i1.RouteConfig(BmiCalculatorRoute.name, path: '/bmi-calculator-view')
      ];
}

class StartupRoute extends _i1.PageRouteInfo {
  const StartupRoute() : super(name, path: '/');

  static const String name = 'StartupRoute';
}

class HomeRoute extends _i1.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({_i2.Key? key, required void Function()? onSeeLeaderboardPressed})
      : super(name,
            path: '/home-view',
            args: HomeRouteArgs(
                key: key, onSeeLeaderboardPressed: onSeeLeaderboardPressed));

  static const String name = 'HomeRoute';
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key, required this.onSeeLeaderboardPressed});

  final _i2.Key? key;

  final void Function()? onSeeLeaderboardPressed;
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

class AccountRoute extends _i1.PageRouteInfo {
  const AccountRoute() : super(name, path: '/account-view');

  static const String name = 'AccountRoute';
}

class RewardsRoute extends _i1.PageRouteInfo {
  const RewardsRoute() : super(name, path: '/rewards-view');

  static const String name = 'RewardsRoute';
}

class HistoryRoute extends _i1.PageRouteInfo {
  const HistoryRoute() : super(name, path: '/history-view');

  static const String name = 'HistoryRoute';
}

class SettingsRoute extends _i1.PageRouteInfo {
  const SettingsRoute() : super(name, path: '/settings-view');

  static const String name = 'SettingsRoute';
}

class EditProfileRoute extends _i1.PageRouteInfo {
  const EditProfileRoute() : super(name, path: '/edit-profile-view');

  static const String name = 'EditProfileRoute';
}

class BmiCalculatorRoute extends _i1.PageRouteInfo {
  const BmiCalculatorRoute() : super(name, path: '/bmi-calculator-view');

  static const String name = 'BmiCalculatorRoute';
}
