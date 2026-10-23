import 'identity.dart';

class Tag implements Identity {
  @override
  final String id;
  final String name;

  Tag({required this.id, required this.name});

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
  };

  factory Tag.fromMap(Map<String, dynamic> map) {
    return Tag(
      id: map['id'] as String,
      name: map['name'] as String,
    );
  }

  @override
  String toString() => name;
}