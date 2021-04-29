import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:steps_tracker/app/global/custom_base_view_model.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/models/k_error.dart';
import 'package:steps_tracker/app/router/router.dart';
import 'package:steps_tracker/app/services/auth_service.dart';
import 'package:steps_tracker/app/services/router_service.dart';
import 'package:steps_tracker/app/utils/flash_helper.dart';
import 'package:steps_tracker/app/utils/utils.dart';
import 'package:steps_tracker/ui/widgets/veritifcation_ui.dart';

class LoginViewModel extends CustomBaseViewModel {
  final AuthService _authService = locator<AuthService>();
  final RouterService _routerService = locator<RouterService>();

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController phoneNumberController = TextEditingController();

  final TextEditingController verificationCodeController =
      TextEditingController();

  bool _autoValidate = false;
  bool get autoValidate => _autoValidate;
  void setAutoValidate(bool newValue) {
    _autoValidate = newValue;
    notifyListeners();
  }

  String _verificationId;
  String get verificationId => _verificationId;
  void setVerificationId(String newValue) {
    _verificationId = newValue;
    notifyListeners();
  }

  int _resendToken;
  int get resendToken => _resendToken;
  void setResendToken(int newValue) {
    _resendToken = newValue;
    notifyListeners();
  }

  ConfirmationResult _confirmationResult;
  ConfirmationResult get confirmationResult => _confirmationResult;
  void setConfirmationResult(ConfirmationResult newValue) {
    _confirmationResult = newValue;
    notifyListeners();
  }

  Future<void> loginUser({
    @required BuildContext context,
  }) async {
    if (loginFormKey.currentState.validate()) {
      setBusy(true);
      final String phoneNumberTrimmed = Utils.formatPhoneNumber(
        phoneNumber: phoneNumberController.text.trim(),
      );

      print("Login existing user");

      final dynamic response = await _getVerificationId(
        phoneNumber: phoneNumberTrimmed,
      );

      /// if error then show error bar
      if (response is KError) {
        setBusy(false);
        return FlashHelper.errorBar(
          context,
          message: response.userFriendlyMessage,
        );
      }

      /// clear to make sure nothing remains in the controller
      verificationCodeController.clear();

      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return VerificationUI(
            controller: verificationCodeController,
            onPressed: () async {
              await doVerification(
                context: context,
                phoneNumber: phoneNumberTrimmed,
              );
            },
          );
        },
      );

      setBusy(false);
    } else {
      setAutoValidate(true);
      FlashHelper.errorBar(
        context,
        message: "Check the info you provided above!",
      );
    }
  }

  Future<dynamic> _getVerificationId({
    @required String phoneNumber,
  }) async {
    /// get verification id
    final dynamic response = await _authService.sendVerificationCode(
      phoneNumber: phoneNumber,
      codeSent: (String verificationId, int resendToken) {
        print(
          "(codeSent) Verification ID: $verificationId",
        );
        print(
          "(codeSent) Resend Token: $resendToken",
        );
        setVerificationId(verificationId);
        setResendToken(resendToken);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(
          "(codeAutoRetrievalTimeout) Verification ID: $verificationId",
        );
        setVerificationId(verificationId);
      },
    );

    return response;
  }

  Future<void> doVerification({
    @required BuildContext context,
    @required String phoneNumber,
  }) async {
    removeFocus();
    final String verificationCodeString =
        verificationCodeController.text.trim();

    if (verificationCodeString.length == 6) {
      /// verify the phone number
      final dynamic response = await _authService.verifyPhoneNumber(
        verificationId: verificationId,
        verificationCode: verificationCodeString,
        phoneNumber: phoneNumber,
      );

      if (response is KError) {
        await FlashHelper.errorBar(
          context,
          message: response.userFriendlyMessage,
        );
        return;
      } else {
        /// go to home view
        await goBack();
        await _routerService.router.pushAndPopUntil(
          MainRoute(),
          predicate: (_) => false,
        );
      }
    }
  }

  Future<void> navigateToRegisterView() async {
    await _routerService.router.pushAndPopUntil(
      RegisterRoute(),
      predicate: (_) => false,
    );
  }
}
