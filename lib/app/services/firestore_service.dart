import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:steps_tracker/app/models/k_reward.dart';
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
  final CollectionReference _rewardsCollection = _firebaseFirestore.collection(
    Constants.rewardsCollectionName,
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

  Future<dynamic> updateStepsCount({
    @required String userId,
    @required int newStepsCount,
  }) async {
    try {
      await _usersCollection.doc(userId).update({
        "stepsCount": newStepsCount,
      });
    } catch (exception) {
      return ErrorService.handleFirestoreExceptions(exception);
    }
  }

  /// [getLeaderboard] gets the leaderboard users from the database.
  Future<dynamic> getLeaderboard() async {
    try {
      final QuerySnapshot querySnapshot =
          await _usersCollection.orderBy("stepsCount", descending: true).get();

      List<KUser> userList = <KUser>[];
      querySnapshot.docs.forEach((QueryDocumentSnapshot documentSnapshot) {
        userList.add(KUser.fromMap(documentSnapshot.data()));
      });

      return userList;
    } catch (exception) {
      return ErrorService.handleFirestoreExceptions(exception);
    }
  }

  /// [getRewards] gets all the rewards.
  Future<dynamic> getRewards() async {
    try {
      final QuerySnapshot querySnapshot =
          await _rewardsCollection.orderBy("createdAt", descending: true).get();

      List<KReward> rewardList = <KReward>[];
      querySnapshot.docs.forEach((QueryDocumentSnapshot documentSnapshot) {
        rewardList.add(KReward.fromMap(documentSnapshot.data()));
      });

      return rewardList;
    } catch (exception) {
      return ErrorService.handleFirestoreExceptions(exception);
    }
  }
}
