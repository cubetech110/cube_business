import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cube_business/model/store_model.dart';
import 'package:cube_business/services/user_service.dart';

class StoreService {
  final CollectionReference storeCollection =
      FirebaseFirestore.instance.collection('stores');

  // Fetch store by ID
  Future<Store?> getStoreById(String storeId) async {
    try {
      DocumentSnapshot doc = await storeCollection.doc(storeId).get();
      if (doc.exists) {
        return Store.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }
    } catch (e) {
      print("Error fetching store: $e");
    }
    return null; // Return null if store not found
  }
Future<void> addStore(Store store) async {
  // إنشاء معرف فريد لـ storeId
  final String storeId = FirebaseFirestore.instance.collection('stores').doc().id;

  // تحديث storeId في المستخدم الحالي
  await UserService().updateStoreId(storeId);

  // تخزين بيانات المتجر باستخدام نفس storeId
  store.id = storeId;
  await storeCollection.doc(storeId).set(store.toFirestore());
}
  // Update store data
  Future<void> updateStore(String storeId, Map<String, dynamic> newData) async {
    try {
      await storeCollection.doc(storeId).update(newData);
    } catch (e) {
      print("Error updating store: $e");
      rethrow;
    }
  }
}
