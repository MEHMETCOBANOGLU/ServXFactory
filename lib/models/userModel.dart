// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  String id;
  String name;
  String email;
  String telNo;
  String adress;
  String role;
  String? imageUrl;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.telNo,
    required this.adress,
    required this.role,
    this.imageUrl,
  });

  // Firebase'den veri almak için bir factory constructor
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
      telNo: data['telNo'] ?? '',
      adress: data['adress'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  // Firebase'e veri göndermek için bir metod
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'telNo': telNo,
      'adress': adress,
      'role': role,
      'imageUrl': imageUrl
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? telNo,
    String? adress,
    String? role,
    String? imageUrl,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      telNo: telNo ?? this.telNo,
      adress: adress ?? this.adress,
      role: role ?? this.role,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, telNo: $telNo, adress: $adress, role: $role, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.telNo == telNo &&
        other.adress == adress &&
        other.role == role &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        telNo.hashCode ^
        adress.hashCode ^
        role.hashCode ^
        imageUrl.hashCode;
  }
}
