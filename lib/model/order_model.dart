import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final String userName;
  final String userPhone;
  final String productDetails;
  final String status;

  OrderModel({
    required this.id,
    required this.userName,
    required this.userPhone,
    required this.productDetails,
    required this.status,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      id: doc.id,
      userName: data['userName'],
      userPhone: data['userPhone'],
      productDetails: data['productDetails'],
      status: data['status'],
    );
  }

  Future<void> updateStatus(String newStatus) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(id)
        .update({'status': newStatus});
  }
}
