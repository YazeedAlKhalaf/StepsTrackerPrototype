import 'package:steps_tracker/app/global/custom_base_view_model.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/router/router.dart';
import 'package:steps_tracker/app/services/auth_service.dart';
import 'package:steps_tracker/app/services/router_service.dart';

class StartupViewModel extends CustomBaseViewModel {
  final AuthService? _authService = locator<AuthService>();
  final RouterService? _routerService = locator<RouterService>();

  Future<void> init() async {
    /// populate current user if is logged in.
    if (_authService!.isUserLoggedIn()) {
      await _authService!.populateCurrentUser();
      await Future.delayed(Duration(seconds: 1));
      await _routerService!.router.pushAndPopUntil(
        MainRoute(),
        predicate: (_) => false,
      );
      return;
    }

    /// go to register view, since user is not logged in.
    await Future.delayed(Duration(seconds: 1));
    await _routerService!.router.pushAndPopUntil(
      RegisterRoute(),
      predicate: (_) => false,
    );
  }
}
