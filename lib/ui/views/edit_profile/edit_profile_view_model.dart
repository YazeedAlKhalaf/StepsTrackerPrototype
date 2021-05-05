import 'dart:io';

import 'package:flutter/material.dart';
import 'package:steps_tracker/app/global/custom_base_view_model.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/models/k_error.dart';
import 'package:steps_tracker/app/router/router.dart';
import 'package:steps_tracker/app/services/firestorage_service.dart';
import 'package:steps_tracker/app/services/firestore_service.dart';
import 'package:steps_tracker/app/services/router_service.dart';
import 'package:steps_tracker/app/utils/flash_helper.dart';

class EditProfileViewModel extends CustomBaseViewModel {
  final FirestoreService? _firestoreService = locator<FirestoreService>();
  final FirestorageService? _firestorageService = locator<FirestorageService>();
  final RouterService? _routerService = locator<RouterService>();

  final GlobalKey<FormState> editProfileFormKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  bool _autoValidate = false;
  bool get autoValidate => _autoValidate;
  void setAutoValidate(bool newValue) {
    _autoValidate = newValue;
    notifyListeners();
  }

  String _progressText = "";
  String get progressText => _progressText;
  void setProgressText(String newValue) {
    _progressText = newValue;
    notifyListeners();
  }

  BuildContext? _context;
  BuildContext? get context => _context;
  void setContext(BuildContext newValue) {
    _context = newValue;
    notifyListeners();
  }

  File? _pickedImage;
  File? get pickedImage => _pickedImage;
  void setPickedImage(File newValue) {
    _pickedImage = newValue;
    notifyListeners();
  }

  Future<void> init({
    required BuildContext context,
  }) async {
    setContext(context);

    await refreshUserData();

    firstNameController.text = currentUser!.firstName!;
    lastNameController.text = currentUser!.lastName!;
  }

  Future<void> updateUser() async {
    if (editProfileFormKey.currentState!.validate()) {
      setProgressText("Validating");
      setBusy(true);

      String? profileImageUrl;

      if (pickedImage != null) {
        setProgressText("Uploading Profile Image");
        final dynamic uploadProfileImageResponse =
            await _firestorageService!.uploadProfileImage(
          pickedImage!,
        );

        if (uploadProfileImageResponse is KError) {
          setBusy(false);
          setProgressText("");
          FlashHelper.errorBar(
            context!,
            message: uploadProfileImageResponse.userFriendlyMessage,
          );

          return;
        }

        profileImageUrl = uploadProfileImageResponse;
        setProgressText("Uploaded Profile Image");
      }

      setProgressText("Updating User Info");
      final dynamic updateUserResponse = await _firestoreService!.updateUser(
        userId: currentFirebaseUser!.uid,
        firstName: currentUser!.firstName,
        lastName: currentUser!.lastName,
        photoUrl: profileImageUrl,
      );
      setProgressText("Updated user data");

      if (updateUserResponse is KError) {
        setBusy(false);
        setProgressText("");
        FlashHelper.errorBar(
          context!,
          message: updateUserResponse.userFriendlyMessage,
        );

        return;
      }
      setBusy(false);
      setProgressText("");
      await refreshUserData();

      await _routerService!.router.pushAndPopUntil(
        StartupRoute(),
        predicate: (_) => false,
      );
    } else {
      setAutoValidate(true);
    }
  }
}
