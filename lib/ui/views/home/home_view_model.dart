import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:steps_tracker/app/global/custom_base_view_model.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/router/router.dart';
import 'package:steps_tracker/app/services/fitness_service.dart';
import 'package:steps_tracker/app/services/router_service.dart';
import 'package:steps_tracker/app/utils/flash_helper.dart';

class HomeViewModel extends CustomBaseViewModel {
  final RouterService _routerService = locator<RouterService>();
  final FitnessService _fitnessService = locator<FitnessService>();

  StreamController<int> stepsCountLocal = StreamController<int>();

  int get stepsGoal => 8000;

  BuildContext _context;
  BuildContext get context => _context;
  void setContext(BuildContext newValue) {
    _context = newValue;
    notifyListeners();
  }

  Future<void> init({
    @required BuildContext context,
  }) async {
    _fitnessService.init();

    stepsCountLocal.stream.listen((int newStepsCount) async {
      if (newStepsCount % 100 == 0) {
        await showUserEarnedHealthPoints();
        return;
      }
    });
    setContext(context);
  }

  Stream<int> getStepsCountStream() {
    return _fitnessService.stepsCountController.stream;
  }

  Future<void> navigateToLeaderboardView() async {
    await _routerService.router.push(
      LeaderboardRoute(),
    );
  }

  Future<void> showUserEarnedHealthPoints() async {
    FlashHelper.successBar(
      context,
      message: "Congrats! You earned 1 health point 🎉!",
    );
    // TODO: add to history of transactions
  }

  @override
  void dispose() {
    stepsCountLocal.close();
    super.dispose();
  }
}
