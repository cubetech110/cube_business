import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/views/pages/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:cube_business/model/user_model.dart';
import 'package:cube_business/model/store_model.dart'; // Assuming you have a Store model
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/services/store_service.dart'; // Your service to fetch store data

class UserProvider with ChangeNotifier {
  UserModel? _currentUser;
  Store? _currentStore;
  bool _isLoading = true; // Start with loading state

  UserModel? get currentUser => _currentUser;
  Store? get currentStore => _currentStore;
  bool get isLoading => _isLoading;

  Future<void> updateEmail(String newEmail) async {
    _isLoading = true;

    _currentUser!.email = newEmail;
    _isLoading = false;

    notifyListeners();
  }
  Future<void> updatePhone(String newPhone) async {
    _isLoading = true;

    _currentUser!.phone = newPhone;
    _isLoading = false;

    notifyListeners();
  }
  Future<void> signOut(BuildContext context) async {
    await AuthService().signOut();
    _currentUser = null;
    _currentStore = null;

    navigateAndRemove(context, LoginScreen());

    // Reset store data on sign out
    notifyListeners();

//[ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Null check operator used on a null value
  }

  Future<void> loadCurrentUser() async {
    _isLoading = true;
    notifyListeners(); // Notify UI to show loading

    try {
      // Load user data
      _currentUser = await AuthService().getCurrentUserData();

      // Load store data if user has a store ID
      if (_currentUser != null && _currentUser!.storeId != null) {
        _currentStore =
            await StoreService().getStoreById(_currentUser!.storeId!);
      }
    } catch (e) {
      print("Error loading user: $e");
    } finally {
      _isLoading = false; // Loading complete
      notifyListeners(); // Notify UI to hide loading and show content
    }
  }
}
