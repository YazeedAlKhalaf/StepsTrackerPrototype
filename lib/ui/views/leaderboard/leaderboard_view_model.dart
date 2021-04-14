import 'package:flutter/material.dart';
import 'package:steps_tracker/app/global/custom_base_view_model.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/models/k_error.dart';
import 'package:steps_tracker/app/models/k_user.dart';
import 'package:steps_tracker/app/services/firestore_service.dart';
import 'package:steps_tracker/app/utils/flash_helper.dart';

class LeaderboardViewModel extends CustomBaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  BuildContext _context;
  BuildContext get context => _context;
  void setContext(BuildContext newValue) {
    _context = newValue;
    notifyListeners();
  }

  Future<void> init({
    @required BuildContext context,
  }) async {
    setContext(context);
  }

  Future<List<KUser>> getLeaderboard() async {
    final dynamic response = await _firestoreService.getLeaderboard();

    if (response is List<KUser>) {
      return response;
    }

    if (response is KError) {
      FlashHelper.errorBar(
        context,
        message: "Can't get leaderboard data!",
      );
    }
    return null;
  }
}
