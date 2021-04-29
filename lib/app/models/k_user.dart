import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import 'package:steps_tracker/app/services/localization_service.dart';

class KUser {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String photoUrl;
  final int stepsCount;
  final int healthPoints;
  final SupportedLocales language;
  final Timestamp createdAt;

  const KUser({
    @required this.id,
    @required this.firstName,
    @required this.lastName,
    @required this.phoneNumber,
    @required this.photoUrl,
    @required this.stepsCount,
    @required this.healthPoints,
    @required this.language,
    @required this.createdAt,
  });

  KUser copyWith({
    String id,
    String firstName,
    String lastName,
    String phoneNumber,
    String photoUrl,
    int stepsCount,
    int healthPoints,
    SupportedLocales language,
    Timestamp createdAt,
  }) {
    return KUser(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      photoUrl: photoUrl ?? this.photoUrl,
      stepsCount: stepsCount ?? this.stepsCount,
      healthPoints: healthPoints ?? this.healthPoints,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'stepsCount': stepsCount,
      'healthPoints': healthPoints,
      'language': convertLanguageEnumToString(language),
      'createdAt': createdAt,
    };
  }

  factory KUser.fromMap(Map<String, dynamic> map) {
    return KUser(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      phoneNumber: map['phoneNumber'],
      photoUrl: map['photoUrl'],
      stepsCount: map['stepsCount'],
      healthPoints: map['healthPoints'],
      language: convertStringToLanguageEnum(map["language"] as String),
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KUser.fromJson(String source) => KUser.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KUser(id: $id, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, photoUrl: $photoUrl, stepsCount: $stepsCount, healthPoints: $healthPoints, language: $language, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KUser &&
        other.id == id &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.phoneNumber == phoneNumber &&
        other.photoUrl == photoUrl &&
        other.stepsCount == stepsCount &&
        other.healthPoints == healthPoints &&
        other.language == language &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        phoneNumber.hashCode ^
        photoUrl.hashCode ^
        stepsCount.hashCode ^
        healthPoints.hashCode ^
        language.hashCode ^
        createdAt.hashCode;
  }
}
