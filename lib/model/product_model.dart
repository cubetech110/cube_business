import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? id;
  String name;
  String description;
  double price;
  int stock;
  String category;
  DateTime createdAt;
  List imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.category,
    required this.createdAt,
    required this.imageUrl,
  });

  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'],
      description: data['description'],
      price: data['price'],
      stock: data['stock'],
      category: data['category'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'category': category,
      'createdAt': createdAt,
      'imageUrl': imageUrl,
    };
  }
}
