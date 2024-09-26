import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cube_business/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('businessUsers');

  // إضافة مستخدم جديد
  Future<void> addUser(UserModel user) {
    return userCollection.doc(user.id).set(user.toFirestore());
  }

  // تحديث بيانات مستخدم موجود
  Future<void> updateUser(UserModel user) {
    return userCollection.doc(user.id).update(user.toFirestore());
  }
  Future<void> updateStoreId(String storeId) async {
    String userId =  FirebaseAuth.instance.currentUser!.uid;
    try {
      await userCollection.doc(userId).update({
        'storeId': storeId,
      });
    } catch (e) {
      print('Error updating storeId: $e');
      throw e;
    }
  }
  // حذف مستخدم
  Future<void> deleteUser(String id) {
    return userCollection.doc(id).delete();
  }

  // جلب مستخدم بناءً على معرفه (ID)
  Future<UserModel?> getUserById(String id) async {
    DocumentSnapshot doc = await userCollection.doc(id).get();
    if (doc.exists) {
      return UserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
    }
    return null;
  }

  // جلب جميع المستخدمين
  Stream<List<UserModel>> getAllUsers() {
    return userCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return UserModel.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }
}
