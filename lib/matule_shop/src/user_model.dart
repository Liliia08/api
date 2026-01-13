class User {
  final String id;
  final String email;
  final String? firstname;
  final String? lastname;
  final bool verified;

  User({
    required this.id,
    required this.email,
    this.firstname,
    this.lastname,
    required this.verified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      firstname: json['firstname'],
      lastname: json['lastname'],
      verified: json['verified'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
      'verified': verified,
    };
  }
}

class AuthResponse {
  final User user;
  final String token;

  AuthResponse({
    required this.user,
    required this.token,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      user: User.fromJson(json['record'] ?? {}),
      token: json['token'] ?? '',
    );
  }
}