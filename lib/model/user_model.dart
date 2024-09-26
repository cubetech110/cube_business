import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String id;
  String fullName;
  String email;
  String role; // 'owner' or 'visitor'
  Timestamp createdAt;
  Timestamp subscribe;
  String? storeId;// if null : detilsScreen else: homeScreen

  // login => EnterdetilsScreen => homeScreen

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.role,
    required this.subscribe,
    required this.createdAt,
    this.storeId,
  });

  factory UserModel.fromFirestore(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      fullName: data['fullName'],
      email: data['email'],
      role: data['role'],
      createdAt: data['createdAt'] as Timestamp,
      subscribe: data['subscribe'] as Timestamp,
      storeId: data['storeId'],
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
