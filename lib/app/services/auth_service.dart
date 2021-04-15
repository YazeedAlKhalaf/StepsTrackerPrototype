import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/app/locator/locator.dart';

import 'package:steps_tracker/app/models/k_user.dart';
import 'package:steps_tracker/app/router/router.dart';
import 'package:steps_tracker/app/services/error_service.dart';
import 'package:steps_tracker/app/services/firestore_service.dart';
import 'package:steps_tracker/app/services/router_service.dart';

@lazySingleton
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final FirestoreService _firestoreService = locator<FirestoreService>();
  final RouterService _routerService = locator<RouterService>();

  KUser _currentUser;
  KUser get currentUser => _currentUser;

  User get currentFirebaseUser => _firebaseAuth.currentUser;

  /// sends the verification code to the provided phone number.
  /// it also creates a user if `firstName` and `lastName` are provided, only on
  /// some android devices!
  /// may return error in case there is.
  Future<dynamic> sendVerificationCode({
    @required String phoneNumber,
    String firstName,
    String lastName,
    @required Function(String, int) codeSent,
    @required Function(String) codeAutoRetrievalTimeout,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          _firebaseAuth.signInWithCredential(phoneAuthCredential);
          if (firstName != null && lastName != null) {
            await _registerUserInDb(
              phoneNumber: phoneNumber,
              firstName: firstName,
              lastName: lastName,
            );
          } else {
            await populateCurrentUser();
          }
          await _routerService.router.pushAndRemoveUntil(
            MainRoute(),
            predicate: (_) => false,
          );
        },
        verificationFailed: (FirebaseAuthException firebaseAuthException) {
          throw firebaseAuthException;
        },
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: const Duration(seconds: 60),
      );
    } on FirebaseAuthException catch (exception) {
      return ErrorService.handleFirebaseAuthExceptions(exception);
    }
  }

  /// verifies the provided phone number.
  /// it also creates a user if `firstName` and `lastName` are provided.
  /// may return error in case there is.
  Future<dynamic> verifyPhoneNumber({
    @required String verificationId,
    @required String verificationCode,
    @required String phoneNumber,
    String firstName,
    String lastName,
  }) async {
    try {
      final AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: verificationCode,
      );

      await _firebaseAuth.signInWithCredential(phoneAuthCredential);

      if (firstName != null && lastName != null) {
        await _registerUserInDb(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
        );
      } else {
        await populateCurrentUser();
      }
    } on FirebaseAuthException catch (exception) {
      return ErrorService.handleFirebaseAuthExceptions(exception);
    }
  }

  /// [_registerUserInDb] uses the [FirestoreService] to save the user to the
  /// database with provided information.
  Future<void> _registerUserInDb({
    @required String phoneNumber,
    @required String firstName,
    @required String lastName,
  }) async {
    _currentUser = KUser(
      id: currentFirebaseUser.uid,
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      photoUrl: null,
      stepsCount: 0,
      createdAt: Timestamp.now(),
    );
    await _firestoreService.createUser(
      user: currentUser,
    );
    await populateCurrentUser();
  }

  /// signs the user out and clears the class from any saved values.
  Future<void> signOut() async {
    _currentUser = null;
    await _firebaseAuth.signOut();
  }

  bool isUserLoggedIn() {
    return currentFirebaseUser != null;
  }

  /// [populateCurrentUser] makes sure the user is populated with latest data
  /// from the database.
  Future<void> populateCurrentUser() async {
    if (isUserLoggedIn()) {
      final dynamic user = await _firestoreService.getUser(
        userId: currentFirebaseUser.uid,
      );

      if (user is KUser) {
        _currentUser = user;
      }
    }
  }
}
