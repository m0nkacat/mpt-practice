import 'identity.dart';

class User implements Identity {
  @override
  final String id;
  final String name;
  final String email;
  final DateTime registeredAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.registeredAt,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'registeredAt': registeredAt.toIso8601String(),
  };

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      registeredAt: DateTime.parse(map['registeredAt'] as String),
    );
  }

  @override
  String toString() => '$name ($email)';
}