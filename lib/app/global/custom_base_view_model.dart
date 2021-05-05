import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:steps_tracker/app/locator/locator.dart';
import 'package:steps_tracker/app/models/k_user.dart';
import 'package:steps_tracker/app/services/auth_service.dart';
import 'package:steps_tracker/app/services/router_service.dart';

abstract class CustomBaseViewModel extends BaseViewModel {
  final AuthService? _authService = locator<AuthService>();
  final RouterService? _routerService = locator<RouterService>();

  KUser? get currentUser => _authService!.currentUser;
  User? get currentFirebaseUser => _authService!.currentFirebaseUser;

  Future<void> goBack() async {
    await _routerService!.router.pop();
  }

  void removeFocus() {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  Future<void> refreshUserData() async {
    await _authService!.populateCurrentUser();
    notifyListeners();
  }
}
