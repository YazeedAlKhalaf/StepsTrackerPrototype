import 'package:flutter/material.dart';
import 'package:steps_tracker/app/global/custom_base_view_model.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/models/k_error.dart';
import 'package:steps_tracker/app/models/k_reward.dart';
import 'package:steps_tracker/app/services/firestore_service.dart';
import 'package:steps_tracker/app/utils/flash_helper.dart';

class RewardsViewModel extends CustomBaseViewModel {
  final FirestoreService? _firestoreService = locator<FirestoreService>();

  BuildContext? _context;
  BuildContext? get context => _context;
  void setContext(BuildContext newValue) {
    _context = newValue;
    notifyListeners();
  }

  List<KReward> _rewardList = <KReward>[];
  List<KReward> get rewardList => _rewardList;
  void setRewardList(List<KReward> newValue) {
    _rewardList = newValue;
    notifyListeners();
  }

  Future<void> init({
    required BuildContext context,
  }) async {
    setContext(context);
    await getRewards();
  }

  Future<void> getRewards() async {
    final dynamic response = await _firestoreService!.getRewards();

    if (response is KError) {
      FlashHelper.errorBar(
        context!,
        message: response.userFriendlyMessage,
      );
      return;
    }

    setRewardList(response);
  }

  Future<void> buyReward({
    required KReward reward,
  }) async {
    final dynamic response = await _firestoreService!.buyReward(
      user: currentUser!,
      reward: reward,
    );

    if (response is KError) {
      FlashHelper.errorBar(
        context!,
        message: response.userFriendlyMessage,
      );
      return;
    }
  }
}
