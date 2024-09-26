import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String id;
  String storeId;
  String userId;//who order it
  List<Map<String, dynamic>> products;//[{'price':20},....]
  double totalPrice;
  String status; // 'pending', 'confirmed', 'shipped'
  DateTime createdAt;

  Order({
    required this.id,
    required this.storeId,
    required this.userId,
    required this.products,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });

  factory Order.fromFirestore(Map<String, dynamic> data, String id) {
    return Order(
      id: id,
      storeId: data['storeId'],
      userId: data['userId'],
      products: List<Map<String, dynamic>>.from(data['products']),
      totalPrice: data['totalPrice'],
      status: data['status'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'storeId': storeId,
      'userId': userId,
      'products': products,
      'totalPrice': totalPrice,
      'status': status,
      'createdAt': createdAt,
    };
  }
}
