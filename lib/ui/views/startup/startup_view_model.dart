import 'package:steps_tracker/app/global/custom_base_view_model.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/router/router.dart';
import 'package:steps_tracker/app/services/router_service.dart';

class StartupViewModel extends CustomBaseViewModel {
  final RouterService _routerService = locator<RouterService>();

  Future<void> init() async {
    await Future.delayed(Duration(seconds: 1));
    await _routerService.router.pushAndRemoveUntil(
      HomeRoute(),
      predicate: (_) => false,
    );
  }
}
