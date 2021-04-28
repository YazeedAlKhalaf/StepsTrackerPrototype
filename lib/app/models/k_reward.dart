import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class KReward {
  final String id;
  final String name;
  final String description;
  final String vendor;
  final String couponCode;
  final List<String> images;
  final int price;
  final String ownerId;
  final Timestamp createdAt;

  bool get isSold => this.ownerId != null;

  KReward({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.vendor,
    @required this.couponCode,
    @required this.images,
    @required this.price,
    @required this.ownerId,
    @required this.createdAt,
  });

  KReward copyWith({
    String id,
    String name,
    String description,
    String vendor,
    String couponCode,
    List<String> images,
    int price,
    String ownerId,
    Timestamp createdAt,
  }) {
    return KReward(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      vendor: vendor ?? this.vendor,
      couponCode: couponCode ?? this.couponCode,
      images: images ?? this.images,
      price: price ?? this.price,
      ownerId: ownerId ?? this.ownerId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'vendor': vendor,
      'couponCode': couponCode,
      'images': images,
      'price': price,
      'ownerId': ownerId,
      'createdAt': createdAt,
    };
  }

  factory KReward.fromMap(Map<String, dynamic> map) {
    return KReward(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      vendor: map['vendor'],
      couponCode: map['couponCode'],
      images: List<String>.from(map['images']),
      price: map['price'],
      ownerId: map['ownerId'],
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());

  factory KReward.fromJson(String source) =>
      KReward.fromMap(json.decode(source));

  @override
  String toString() {
    return 'KReward(id: $id, name: $name, description: $description, vendor: $vendor, couponCode: $couponCode, images: $images, price: $price, ownerId: $ownerId, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is KReward &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.vendor == vendor &&
        other.couponCode == couponCode &&
        listEquals(other.images, images) &&
        other.price == price &&
        other.ownerId == ownerId &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        vendor.hashCode ^
        couponCode.hashCode ^
        images.hashCode ^
        price.hashCode ^
        ownerId.hashCode ^
        createdAt.hashCode;
  }
}
