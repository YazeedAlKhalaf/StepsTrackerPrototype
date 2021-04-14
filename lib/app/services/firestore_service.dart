import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/app/models/k_user.dart';
import 'package:steps_tracker/app/services/error_service.dart';
import 'package:steps_tracker/app/utils/constants.dart';

@lazySingleton
class FirestoreService {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  final CollectionReference _usersCollection = _firebaseFirestore.collection(
    Constants.usersCollectionName,
  );

  /// create user with provided user model.
  /// may return error in case there is.
  Future<dynamic> createUser({
    @required KUser user,
  }) async {
    try {
      await _usersCollection.doc(user.id).set(user.toMap());
      print("Created user with data: ${user.toString()}");
    } catch (exception) {
      ErrorService.handleUnknownErrors(exception);
    }
  }

  /// get user with provided `userId`.
  /// may return error in case there is.
  Future<dynamic> getUser({
    @required String userId,
  }) async {
    try {
      final DocumentSnapshot documentSnapshot =
          await _usersCollection.doc(userId).get();
      final KUser user = KUser.fromMap(documentSnapshot.data());
      print("Got user with data: ${user.toString()}");

      return user;
    } catch (exception) {
      return ErrorService.handleFirestoreExceptions(exception);
    }
  }
}
