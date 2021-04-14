import 'package:steps_tracker/app/global/custom_base_view_model.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/router/router.dart';
import 'package:steps_tracker/app/services/auth_service.dart';
import 'package:steps_tracker/app/services/fitness_service.dart';
import 'package:steps_tracker/app/services/router_service.dart';

class HomeViewModel extends CustomBaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final RouterService _routerService = locator<RouterService>();
  final FitnessService _fitnessService = locator<FitnessService>();

  int get stepsGoal => 8000;

  Future<void> init() async {
    _fitnessService.init();
  }

  Stream<int> getStepsCountStream() {
    return _fitnessService.stepsCountController.stream;
  }

  Future<void> signOut() async {
    setBusy(true);
    await _authService.signOut();

    await _routerService.router.pushAndRemoveUntil(
      RegisterRoute(),
      predicate: (_) => false,
    );
    setBusy(false);
  }
}
