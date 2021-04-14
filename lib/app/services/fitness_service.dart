import 'dart:async';
import 'dart:developer';

import 'package:injectable/injectable.dart';
import 'package:pedometer/pedometer.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/services/auth_service.dart';
import 'package:steps_tracker/app/services/firestore_service.dart';

@lazySingleton
class FitnessService {
  final AuthService _authService = locator<AuthService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  Stream<StepCount> _stepCountStream;

  StreamController<int> _stepsCountController = StreamController<int>();
  StreamController<int> get stepsCountController => _stepsCountController;

  /// does things every step, triggered by listening to the [_stepCountStream].
  Future<void> _onStepCount(StepCount event) async {
    int steps = event.steps;
    DateTime timestamp = event.timeStamp;

    log(
      "Step Count: $steps at ${timestamp.toLocal().toIso8601String()}",
      name: "steps_tracker/FitnessService",
      time: timestamp,
    );

    _stepsCountController.add(steps);
    await _firestoreService.updateStepsCount(
      userId: _authService.currentUser.id,
      newStepsCount: steps,
    );
  }

  /// handles steps count errors, triggered by listening
  /// to the [_stepCountStream].
  void _onStepCountError(error) {
    log(
      "Steps Count Error: $error",
      name: "steps_tracker/FitnessService",
      time: DateTime.now(),
    );
  }

  /// initialzes fitness
  void init() {
    clear();

    /// intialize streams
    _stepCountStream = Pedometer.stepCountStream;

    /// listen to steps count stream
    _stepCountStream.listen(_onStepCount).onError(_onStepCountError);
  }

  /// clears the class from all info saved
  void clear() {
    _stepCountStream = null;
    _stepsCountController = StreamController<int>();
  }
}
