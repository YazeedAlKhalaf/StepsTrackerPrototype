import 'package:steps_tracker/app/global/custom_base_view_model.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/router/router.dart';
import 'package:steps_tracker/app/services/auth_service.dart';
import 'package:steps_tracker/app/services/router_service.dart';

class AccountViewModel extends CustomBaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final RouterService _routerService = locator<RouterService>();

  Future<void> signOut() async {
    setBusy(true);
    await _authService.signOut();

    await _routerService.router.pushAndRemoveUntil(
      RegisterRoute(),
      predicate: (_) => false,
    );
    setBusy(false);
  }

  Future<void> navigateToHistoryView() async {
    await _routerService.router.push(HistoryRoute());
  }

  Future<void> navigateToSettingsView() async {
    await _routerService.router.push(SettingsRoute());
  }

  Future<void> navigateToEditProfileView() async {
    await _routerService.router.push(EditProfileRoute());
  }
}
