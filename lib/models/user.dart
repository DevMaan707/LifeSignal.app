class User {
  String id;
  String username;
  String email;
  String phone;
  String firstName;
  String lastName;
  String passwordHash;
  DateTime createdAt;
  DateTime updatedAt;

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
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      passwordHash: json['password_hash'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
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
