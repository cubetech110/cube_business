import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cube_business/model/user_model.dart';
import 'package:cube_business/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('businessUsers');




  Future<UserModel?> getCurrentUserData() async {
    final currentUser = _auth.currentUser;
    if (currentUser != null) {
      final userDataSnapshot =
          await userCollection.doc(currentUser.uid).get();
      if (userDataSnapshot.exists) {
        return UserModel.fromFirestore(
            userDataSnapshot.data() as Map<String, dynamic>, currentUser.uid);
      }
    }
    return null;
  }

  // Future<UserModel?> getDataUser(String uid) async {
  //   final userDataSnapshot =
  //       await userCollection.doc(uid).get();
  //   if (userDataSnapshot.exists) {
  //     return UserModel.fromFirestore(
  //         userDataSnapshot.data() as Map<String, dynamic>, uid);
  //   }
  //   return null;
  // }

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<User?> signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      if (user != null) {
        UserModel newUser = UserModel(
          id: user.uid,
          email: email,
          subscribe: Timestamp.now(),
          fullName: fullName,
          storeId: '',
          createdAt: Timestamp.now(),
          role: 'owner',
        );

        await UserService().addUser(newUser);
      }
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> updateImageUrl(String uid, String pathImage) async {
    try {
      await userCollection.doc(uid).update({
        'photoURL': pathImage,
      });
    } catch (e) {
      print("Error updating image URL: $e");
    }
  }

  Future<void> removePlayerId(String uid) async {
    try {
      await userCollection.doc(uid).update({
        'playerId': '',
      });
    } catch (e) {
      print("Error updating player ID: $e");
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);

      final User? user = result.user;
      if (user != null) {
        final userDoc =
            await userCollection.doc(user.uid).get();
        if (!userDoc.exists) {
          UserModel newUser = UserModel(
            id: user.uid,
            email: user.email!,
            subscribe: Timestamp.now(),
            fullName: user.displayName!,
            storeId: '',
            createdAt: Timestamp.now(),
            role: 'owner',
          );

          await UserService().addUser(newUser);
        }
      }
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      UserCredential result = await _auth.signInWithCredential(oauthCredential);

      final User? user = result.user;
      if (user != null) {
        final userDoc =
            await userCollection.doc(user.uid).get();
        if (!userDoc.exists) {
          UserModel newUser = UserModel(
            id: user.uid,
            email: user.email!,
            subscribe: Timestamp.now(),
            fullName: user.displayName!,
            storeId: '',
            createdAt: Timestamp.now(),
            role: 'owner',
          );

          await UserService().addUser(newUser);
        }
      }
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        await removePlayerId(currentUser.uid);
      }
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
