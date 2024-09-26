import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  String? id;
  String name;
  String ownerId;
  String location;
  DateTime createdAt;
  int visitorCount;
  String categories;
String? logoUrl;
  Store({
     this.id,
    required this.name,
    required this.ownerId,
    required this.location,
    required this.createdAt,
    required this.visitorCount,
    required this.categories, this.logoUrl,
  });

  // تحويل المستند من Firestore إلى Store
  factory Store.fromFirestore(Map<String, dynamic> data, String id) {
    return Store(
      id: id,
      name: data['name'],
      ownerId: data['ownerId'],
      location: data['location'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      visitorCount: data['visitorCount'],
      categories: data['categories'],
      logoUrl: data['logoUrl'],
    );
  }

  // تحويل Store إلى مستند قابل للتخزين في Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'ownerId': ownerId,
      'location': location,
      'createdAt': createdAt,
      'visitorCount': visitorCount,
      'categories': categories,
      'logoUrl': logoUrl,
    };
  }
}
