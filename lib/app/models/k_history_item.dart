import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:steps_tracker/app/models/k_reward.dart';

class KHistoryItem {
  final String id;
  final int amount;
  final bool isIncrease;

  /// if the value is `null` this means no reward was bought with health points
  final KReward rewardAtTimeOfTransaction;
  final Timestamp createdAt;

  const KHistoryItem({
    @required this.id,
    @required this.amount,
    @required this.isIncrease,
    @required this.rewardAtTimeOfTransaction,
    @required this.createdAt,
  });

  KHistoryItem copyWith({
    String id,
    int amount,
    bool isIncrease,
    KReward rewardAtTimeOfTransaction,
    Timestamp createdAt,
  }) {
    return KHistoryItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      isIncrease: isIncrease ?? this.isIncrease,
      rewardAtTimeOfTransaction:
          rewardAtTimeOfTransaction ?? this.rewardAtTimeOfTransaction,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'isIncrease': isIncrease,
      'rewardAtTimeOfTransaction': rewardAtTimeOfTransaction.toMap(),
      'createdAt': createdAt,
    };
  }

  factory KHistoryItem.fromMap(Map<String, dynamic> map) {
    return KHistoryItem(
      id: map['id'],
      amount: map['amount'],
      isIncrease: map['isIncrease'],
      rewardAtTimeOfTransaction:
          KReward.fromMap(map['rewardAtTimeOfTransaction']),
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KHistoryItem.fromJson(String source) =>
      KHistoryItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KHistoryItem(id: $id, amount: $amount, isIncrease: $isIncrease, rewardAtTimeOfTransaction: $rewardAtTimeOfTransaction, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KHistoryItem &&
        other.id == id &&
        other.amount == amount &&
        other.isIncrease == isIncrease &&
        other.rewardAtTimeOfTransaction == rewardAtTimeOfTransaction &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        isIncrease.hashCode ^
        rewardAtTimeOfTransaction.hashCode ^
        createdAt.hashCode;
  }
}
