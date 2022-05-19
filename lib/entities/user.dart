import 'dart:ffi';

class User {
  final String username;
  final Array role;

  const User({
    required this.username,
    required this.role,
  });
//update Client
  User copy({
    String? username,
    Array? role,
  }) =>
      User(
        username: username ?? this.username,
        role: role ?? this.role,
      );
}
