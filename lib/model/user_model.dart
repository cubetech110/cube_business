import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? fullName;
  String? email;
  String? role; // 'owner' or 'visitor'
  Timestamp? createdAt;
  Timestamp? subscribe;
  String? storeId; // if null: EnterDetailsScreen, else: homeScreen

  UserModel({
    this.id,
    this.fullName,
    this.email,
    this.role,
    this.subscribe,
    this.createdAt,
    this.storeId,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      fullName: data['fullName'] ?? '', // Provide fallback if fullName is null
      email: data['email'] ?? '', // Provide fallback if email is null
      role: data['role'] ?? 'visitor', // Default role is 'visitor'
      createdAt: data['createdAt'] != null ? data['createdAt'] as Timestamp : null,
      subscribe: data['subscribe'] != null ? data['subscribe'] as Timestamp : null,
      storeId: data['storeId'], // storeId can be null
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'fullName': fullName,
      'email': email,
      'role': role,
      'createdAt': createdAt,
      'subscribe': subscribe,
      'storeId': storeId,
    };
  }
}
