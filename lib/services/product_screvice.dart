import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cube_business/model/product_model.dart';
import 'package:cube_business/services/upload_image_service.dart';

class ProductService {
  final String storeId;

  ProductService({required this.storeId});




  CollectionReference get productCollection {
    return FirebaseFirestore.instance
        .collection('stores')
        .doc(storeId)
        .collection('product');
  } 
  
  

  Future<int> countProducts() async {
    QuerySnapshot snapshot = await productCollection.get();
    return snapshot.docs.length;
  }
  Future<void> addProduct(Product product) {
    return productCollection.doc(product.id).set(product.toFirestore());
  }
    Future<bool> checkProductsAvailability() async {
    QuerySnapshot snapshot = await productCollection.limit(1).get();
    return snapshot.docs.isNotEmpty;
  }
  Future<void> addProductWithImage(Product product, File imageFile) async {
    try {
      String imageUrl = await uploadImage(imageFile);
      product.imageUrl.add(imageUrl);
      await addProduct(product);
    } catch (e) {
      print('Error uploading image: $e');
      throw e;
    }
  }
  // تحديث بيانات منتج موجود
  Future<void> updateProduct(Product product) {
    return productCollection.doc(product.id).update(product.toFirestore());
  }

  // حذف منتج من المخزون
  Future<void> deleteProduct(String id) {
    return productCollection.doc(id).delete();
  }

  // جلب منتج بناءً على معرفه (ID)
  Future<Product?> getProductById(String id) async {
    DocumentSnapshot doc = await productCollection.doc(id).get();
    if (doc.exists) {
      return Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  // جلب جميع المنتجات في المخزون
  Stream<List<Product>> getAllProducts() {
    return productCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Product.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
