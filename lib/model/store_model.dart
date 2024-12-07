import 'package:cloud_firestore/cloud_firestore.dart';

class Store {
  String? id;
  String name;
  String ownerId;
  String location;
  String? premotionUrl;
  DateTime createdAt;
  int visitorCount;
  String categories;
  bool aictived;
String? logoUrl;
  Store({
     this.id,
    required this.name,
    required this.ownerId,
    required this.location,
    required this.createdAt,
    required this.visitorCount,
    required this.categories, this.logoUrl,this.premotionUrl,
    required this.aictived
  });

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
      premotionUrl: data['premotionUrl'],
      aictived:data['aictived']??false

    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'ownerId': ownerId,
      'location': location,
      'createdAt': createdAt,
      'visitorCount': visitorCount,
      'categories': categories,
      'logoUrl': logoUrl,
      'premotionUrl':premotionUrl,
      'actived':aictived
    };
  }
}
