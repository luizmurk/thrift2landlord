import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? photoUrl;
  final String? role;
  final DateTime? createdAt;
  final int? rating;
  final int? propertiesListed;
  final List<String>? achievements; // Stores milestone achievements

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.photoUrl,
    this.role,
    this.createdAt,
    this.rating,
    this.propertiesListed,
    this.achievements,
  });

  // Convert Firestore document to UserModel
  factory UserModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserModel(
      id: docId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      photoUrl: map['photoUrl'],
      role: map['role'] ?? 'user',
      createdAt: DateTime.now(),
      rating: 0,
      propertiesListed: 0,
      achievements: List<String>.from(map['achievements'] ?? []),
    );
  }

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'role': role,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'rating': rating ?? 0,
      'propertiesListed': propertiesListed ?? 0,
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
