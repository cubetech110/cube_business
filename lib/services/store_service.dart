import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cube_business/model/store_model.dart';
import 'package:cube_business/model/user_model.dart';
import 'package:cube_business/services/user_service.dart';

class StoreService {
  final CollectionReference storeCollection =
      FirebaseFirestore.instance.collection('stores');

Future<void> addStore(Store store) async {
  // إنشاء معرف فريد لـ storeId
  final String storeId = FirebaseFirestore.instance.collection('stores').doc().id;

  // تحديث storeId في المستخدم الحالي
  await UserService().updateStoreId(storeId);

  // تخزين بيانات المتجر باستخدام نفس storeId
  store.id = storeId;
  await storeCollection.doc(storeId).set(store.toFirestore());
}

  Future<void> updateStore(Store store) {
    return storeCollection.doc(store.id).update(store.toFirestore());
  }

  Future<void> deleteStore(String id) {
    return storeCollection.doc(id).delete();
  }

  // Future<Store?> getStoreById(String id) async {
  //   DocumentSnapshot doc = await storeCollection.doc(id).get();
  //   if (doc.exists) {
  //     return Store.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
  //   }
  //   return null;
  // }

  // Stream<List<Store>> getAllStores() {
  //   return storeCollection.snapshots().map((snapshot) {
  //     return snapshot.docs
  //         .map((doc) =>
  //             Store.fromFirestore(doc.data() as Map<String, dynamic>, doc.id))
  //         .toList();
  //   });
  // }
}
