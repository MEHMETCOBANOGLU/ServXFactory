class UserModel {
  String id;
  String name;
  String email;
  String role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  // Firebase'den veri almak için bir factory constructor
  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      id: data['id'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['role'] ?? '',
    );
  }

  // Firebase'e veri göndermek için bir metod
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
    };
  }
}
