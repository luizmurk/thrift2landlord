import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final String? role;
  final DateTime? createdAt;
  final List<String>? achievements; // Stores milestone achievements

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    this.role,
    this.createdAt,
    this.achievements,
  });

  // Convert Firestore document to UserModel
  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
      id: docId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      photoUrl: map['photoUrl'],
      role: map['role'] ?? 'user',
      createdAt: DateTime.now(),
      achievements: List<String>.from(map['achievements'] ?? []),
    );
  }

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'role': role,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'achievements': achievements ?? [],
    };
  }

  // Convert to JSON (for SharedPreferences)
  String toJson() => json.encode(toMap());

  // Convert from JSON
  factory UserModel.fromJson(String source) {
    var res = UserModel.fromMap(json.decode(source), json.decode(source)['id']);
    return res;
  }
}
