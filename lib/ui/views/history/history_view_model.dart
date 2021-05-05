import 'package:flutter/material.dart';
import 'package:steps_tracker/app/global/custom_base_view_model.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/models/k_error.dart';
import 'package:steps_tracker/app/models/k_history_item.dart';
import 'package:steps_tracker/app/services/firestore_service.dart';
import 'package:steps_tracker/app/utils/flash_helper.dart';

class HistoryViewModel extends CustomBaseViewModel {
  final FirestoreService? _firestoreService = locator<FirestoreService>();

  List<KHistoryItem> _historyItems = <KHistoryItem>[];
  List<KHistoryItem> get historyItems => _historyItems;

  void setHistoryItems(List<KHistoryItem> newValue) {
    _historyItems = newValue;
    notifyListeners();
  }

  BuildContext? _context;
  BuildContext? get context => _context;
  void setContext(BuildContext newValue) {
    _context = newValue;
    notifyListeners();
  }

  Future<void> init({
    required BuildContext context,
  }) async {
    setContext(context);
    await getHistoryItems();
  }

  Future<void> getHistoryItems() async {
    setBusy(true);
    final dynamic response = await _firestoreService!.getHistoryItems(
      userId: currentFirebaseUser!.uid,
    );

    if (response is KError) {
      setBusy(false);
      FlashHelper.errorBar(
        context!,
        message: response.userFriendlyMessage,
      );
      return;
    }

    setHistoryItems(response);
    setBusy(false);
  }
}
