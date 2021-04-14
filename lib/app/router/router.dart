import 'package:auto_route/auto_route.dart';
import 'package:steps_tracker/ui/views/home/home_view.dart';
import 'package:steps_tracker/ui/views/startup/startup_view.dart';

export './router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute<dynamic>>[
    AutoRoute(page: StartupView, initial: true),
    AutoRoute(page: HomeView),
  ],
)
class $StepsTrackerRouter {}
