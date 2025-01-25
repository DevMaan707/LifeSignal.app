class User {
  final String id;
  final String username;
  final String email;
  final String phone;
  final String firstName;
  final String lastName;
  final String passwordHash;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
    required this.passwordHash,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? "",
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      phone: json['phone'] ?? "",
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      passwordHash: json['password_hash'] ?? "",
      createdAt:
          DateTime.tryParse(json['created_at'] ?? "") ?? DateTime(1970, 1, 1),
      updatedAt:
          DateTime.tryParse(json['updated_at'] ?? "") ?? DateTime(1970, 1, 1),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'first_name': firstName,
      'last_name': lastName,
      'password_hash': passwordHash,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
