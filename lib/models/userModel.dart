// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  String id;
  String name;
  String email;
  String phoneNumber;
  String adress;
  String role;
  String? imageUrl;
  String image;
  String token;
  String aboutMe;
  String lastSeen;
  String createdAt;
  bool isOnline;
  List<String> friendsUIDs;
  List<String> friendRequestsUIDs;
  List<String> sentFriendRequestsUIDs;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.adress,
    required this.role,
    this.imageUrl,
    required this.image,
    required this.token,
    required this.aboutMe,
    required this.lastSeen,
    required this.createdAt,
    required this.isOnline,
    required this.friendsUIDs,
    required this.friendRequestsUIDs,
    required this.sentFriendRequestsUIDs,
  });

  // Firebase'den veri almak için bir factory constructor
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      adress: data['adress'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      // image: data[Constants.image] ?? '',
      image: data['image'] ?? '',
      token: data['token'] ?? '',
      aboutMe: data['aboutMe'] ?? '',
      lastSeen: data['lastSeen'] ?? '',
      createdAt: data['createdAt'] ?? '',
      isOnline: data['isOnline'] ?? false,
      friendsUIDs: List<String>.from(data['friendsUIDs'] ?? []),
      friendRequestsUIDs: List<String>.from(data['friendRequestsUIDs'] ?? []),
      sentFriendRequestsUIDs:
          List<String>.from(data['sentFriendRequestsUIDs'] ?? []),
    );
  }

  // Firebase'e veri göndermek için bir metod
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'adress': adress,
      'role': role,
      'imageUrl': imageUrl,
      'image': image,
      'token': token,
      'aboutMe': aboutMe,
      'lastSeen': lastSeen,
      'createdAt': createdAt,
      'isOnline': isOnline,
      'friendsUIDs': friendsUIDs,
      'friendRequestsUIDs': friendRequestsUIDs,
      'sentFriendRequestsUIDs': sentFriendRequestsUIDs,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? adress,
    String? role,
    String? imageUrl,
    String? image,
    String? token,
    String? aboutMe,
    String? lastSeen,
    String? createdAt,
    bool? isOnline,
    List<String>? friendsUIDs,
    List<String>? friendRequestsUIDs,
    List<String>? sentFriendRequestsUIDs,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      adress: adress ?? this.adress,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
      image: image ?? this.image,
      token: token ?? this.token,
      aboutMe: aboutMe ?? this.aboutMe,
      lastSeen: lastSeen ?? this.lastSeen,
      createdAt: createdAt ?? this.createdAt,
      isOnline: isOnline ?? this.isOnline,
      friendsUIDs: friendsUIDs ?? this.friendsUIDs,
      friendRequestsUIDs: friendRequestsUIDs ?? this.friendRequestsUIDs,
      sentFriendRequestsUIDs:
          sentFriendRequestsUIDs ?? this.sentFriendRequestsUIDs,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, adress: $adress, role: $role, imageUrl: $imageUrl, image: $image, token: $token, aboutMe: $aboutMe, lastSeen: $lastSeen, createdAt: $createdAt, isOnline: $isOnline, friendsUIDs: $friendsUIDs, friendRequestsUIDs: $friendRequestsUIDs, sentFriendRequestsUIDs: $sentFriendRequestsUIDs)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.adress == adress &&
        other.role == role &&
        other.imageUrl == imageUrl &&
        other.image == image &&
        other.token == token &&
        other.aboutMe == aboutMe &&
        other.lastSeen == lastSeen &&
        other.createdAt == createdAt &&
        other.isOnline == isOnline &&
        listEquals(other.friendsUIDs, friendsUIDs) &&
        listEquals(other.friendRequestsUIDs, friendRequestsUIDs) &&
        listEquals(other.sentFriendRequestsUIDs, sentFriendRequestsUIDs);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        adress.hashCode ^
        role.hashCode ^
        imageUrl.hashCode ^
        image.hashCode ^
        token.hashCode ^
        aboutMe.hashCode ^
        lastSeen.hashCode ^
        createdAt.hashCode ^
        isOnline.hashCode ^
        friendsUIDs.hashCode ^
        friendRequestsUIDs.hashCode ^
        sentFriendRequestsUIDs.hashCode;
  }
}
