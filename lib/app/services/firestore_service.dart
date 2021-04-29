import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart' as intl;

import 'package:steps_tracker/app/models/k_history_item.dart';
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
      final DocumentSnapshot documentSnapshot = await _usersCollection
          .doc(userId)
          .collection(Constants.stepsCollectionName)
          .doc(intl.DateFormat("MM-dd-yyyy").format(DateTime.now()))
          .get();

      if (documentSnapshot.exists) {
        /// increase today's steps count.
        await _usersCollection
            .doc(userId)
            .collection(Constants.stepsCollectionName)
            .doc(intl.DateFormat("MM-dd-yyyy").format(DateTime.now()))
            .update({
          "stepsCount": newStepsCount,
        });
      }

      if (!documentSnapshot.exists) {
        /// increase today's steps count, but first create the document.
        await _usersCollection
            .doc(userId)
            .collection(Constants.stepsCollectionName)
            .doc(intl.DateFormat("MM-dd-yyyy").format(DateTime.now()))
            .set({
          "id": documentSnapshot.id,
          "stepsCount": newStepsCount,
          "createdAt": Timestamp.now(),
        });
      }

      final KUser currentUserData = KUser.fromMap(
        (await _usersCollection.doc(userId).get()).data(),
      );

      /// increase total steps count by 1.
      /// by difference between old and new step count. (future update)
      await _usersCollection.doc(userId).update({
        "stepsCount": FieldValue.increment(
          newStepsCount - currentUserData.stepsCount,
        ),
      });
    } catch (exception) {
      return ErrorService.handleFirestoreExceptions(exception);
    }
  }

  /// [getLeaderboard] gets the leaderboard users from the database.
  Future<dynamic> getLeaderboard() async {
    try {
      final QuerySnapshot querySnapshot = await _usersCollection
          .orderBy("stepsCount", descending: true)
          .limit(50)
          .get();

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

  /// [addHistoryItem] adds a history item for the current user.
  /// provide the [historyItem] with a `null` value for `id`, will be filled
  /// before pushing to firebase firestore.
  Future<dynamic> addHistoryItem({
    @required String userId,
    @required KHistoryItem historyItem,
  }) async {
    try {
      final DocumentReference documentReference = _usersCollection
          .doc(userId)
          .collection(Constants.historyCollectionName)
          .doc();

      await documentReference.set(
        historyItem.copyWith(id: documentReference.id).toMap(),
      );
    } catch (exception) {
      return ErrorService.handleFirestoreExceptions(exception);
    }
  }

  /// [updateHealthPoints] updates health points number and adds to history.
  Future<dynamic> updateHealthPoints({
    @required String userId,
  }) async {
    try {
      /// increase health points by one.
      await _usersCollection.doc(userId).update({
        "healthPoints": FieldValue.increment(1),
      });
    } catch (exception) {
      return ErrorService.handleFirestoreExceptions(exception);
    }
  }

  /// [getHistoryItems] gets all history items of current user.
  Future<dynamic> getHistoryItems({
    @required String userId,
  }) async {
    try {
      final QuerySnapshot querySnapshot = await _usersCollection
          .doc(userId)
          .collection(Constants.historyCollectionName)
          .orderBy("createdAt", descending: true)
          .get();

      List<KHistoryItem> historyItems = <KHistoryItem>[];

      querySnapshot.docs.forEach((QueryDocumentSnapshot documentSnapshot) {
        historyItems.add(KHistoryItem.fromMap(documentSnapshot.data()));
      });

      return historyItems;
    } catch (exception) {
      return ErrorService.handleFirestoreExceptions(exception);
    }
  }

  /// [buyReward] buys a reward for the current user.
  Future<dynamic> buyReward({
    @required KUser user,
    @required KReward reward,
  }) async {
    try {
      if (user.healthPoints >= reward.price && reward.ownerId == null) {
        /// buy the reward for the user.
        await _rewardsCollection.doc(reward.id).update({
          "ownerId": user.id,
        });

        /// decrease health points of user.
        await _usersCollection.doc(user.id).update({
          "healthPoints": FieldValue.increment(-reward.price),
        });

        /// add to history
        await addHistoryItem(
          userId: user.id,
          historyItem: KHistoryItem(
            id: null,
            amount: reward.price,
            rewardAtTimeOfTransaction: reward,
            createdAt: Timestamp.now(),
          ),
        );
      }
    } catch (exception) {
      return ErrorService.handleFirestoreExceptions(exception);
    }
  }

  /// [updateUser] updates user data.
  Future<dynamic> updateUser({
    @required String userId,
    @required String firstName,
    @required String lastName,
    @required String photoUrl,
  }) async {
    try {
      await _usersCollection.doc(userId).update({
        "firstName": firstName,
        "lastName": lastName,
        "photoUrl": photoUrl,
      });
    } catch (exception) {
      return ErrorService.handleFirestoreExceptions(exception);
    }
  }
}
