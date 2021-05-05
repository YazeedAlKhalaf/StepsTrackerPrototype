import 'package:auto_route/auto_route.dart';
import 'package:steps_tracker/ui/views/account/account_view.dart';
import 'package:steps_tracker/ui/views/bmi_calculator/bmi_calculator_view.dart';
import 'package:steps_tracker/ui/views/edit_profile/edit_profile_view.dart';
import 'package:steps_tracker/ui/views/history/history_view.dart';
import 'package:steps_tracker/ui/views/home/home_view.dart';
import 'package:steps_tracker/ui/views/leaderboard/leaderboard_view.dart';
import 'package:steps_tracker/ui/views/login/login_view.dart';
import 'package:steps_tracker/ui/views/main/main_view.dart';
import 'package:steps_tracker/ui/views/register/register_view.dart';
import 'package:steps_tracker/ui/views/rewards/rewards_view.dart';
import 'package:steps_tracker/ui/views/settings/settings_view.dart';
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
    AutoRoute(page: HistoryView),
    AutoRoute(page: SettingsView),
    AutoRoute(page: EditProfileView),
    AutoRoute(page: BmiCalculatorView),
  ],
)
class $StepsTrackerRouter {}
