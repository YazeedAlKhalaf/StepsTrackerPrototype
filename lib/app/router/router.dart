import 'package:auto_route/auto_route.dart';
import 'package:steps_tracker/ui/views/account/account_view.dart';
import 'package:steps_tracker/ui/views/home/home_view.dart';
import 'package:steps_tracker/ui/views/leaderboard/leaderboard_view.dart';
import 'package:steps_tracker/ui/views/login/login_view.dart';
import 'package:steps_tracker/ui/views/main/main_view.dart';
import 'package:steps_tracker/ui/views/register/register_view.dart';
import 'package:steps_tracker/ui/views/rewards/rewards_view.dart';
import 'package:steps_tracker/ui/views/startup/startup_view.dart';

export './router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute<dynamic>>[
    AutoRoute(page: StartupView, initial: true),
    AutoRoute(page: HomeView),
    AutoRoute(page: RegisterView),
    AutoRoute(page: LoginView),
    AutoRoute(page: LeaderboardView),
    AutoRoute(page: MainView),
    AutoRoute(page: AccountView),
    AutoRoute(page: RewardsView),
  ],
)
class $StepsTrackerRouter {}
