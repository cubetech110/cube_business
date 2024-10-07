import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/views/pages/home/home_screen.dart';

class Auth_Provider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;
  User? _currentUser;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  User? get currentUser => _currentUser;

  // Register with email and password
  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
    required BuildContext context,
  }) async {
    // Check if fields are empty and show error message if necessary
    if (email.isEmpty) {
      _setErrorMessage("Email is required");
      return;
    } else if (password.isEmpty) {
      _setErrorMessage("Password is required");
      return;
    } else if (fullName.isEmpty) {
      _setErrorMessage("Full name is required");
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _authService.registerWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
      );

      if (_currentUser != null) {
        _navigateToHome(context);
      }
    } catch (e) {
      _setErrorMessage("Failed to sign up: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign in with email and password
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    // Check if fields are empty and show error message if necessary
    if (email.isEmpty) {
      _setErrorMessage("Email is required");
      return;
    } else if (password.isEmpty) {
      _setErrorMessage("Password is required");
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (_currentUser != null) {
        _navigateToHome(context);
      }
    } catch (e) {
      _setErrorMessage("Failed to sign in: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign in with Google
  Future<void> signInWithGoogle(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _authService.signInWithGoogle();

      if (_currentUser != null) {
        _navigateToHome(context);
      }
    } catch (e) {
      _setErrorMessage("Failed to sign in with Google: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign in with Apple
  Future<void> signInWithApple(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentUser = await _authService.signInWithApple();

      if (_currentUser != null) {
        _navigateToHome(context);
      }
    } catch (e) {
      _setErrorMessage("Failed to sign in with Apple: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Sign out
  Future<void> signOut() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.signOut();
      _currentUser = null;
    } catch (e) {
      _setErrorMessage("Failed to sign out: ${e.toString()}");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Set error message
  void _setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  // Navigate to the Home screen
  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }
}
