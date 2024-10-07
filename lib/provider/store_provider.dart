import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cube_business/model/store_model.dart';
import 'package:cube_business/services/store_service.dart';

class StoreProvider with ChangeNotifier {
  Store? _currentStore;
  bool _isLoading = false;
  String? _errorMessage;

  Store? get currentStore => _currentStore;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Load store data by ID
  Future<void> loadStoreById(String storeId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      // Debugging: Print to ensure storeId is valid
      print("Loading store with ID: $storeId");

      _currentStore = await StoreService().getStoreById(storeId);
      
      // Debugging: Check if store is found
      if (_currentStore == null) {
        _errorMessage = "Store not found!";
        print("Store not found with ID: $storeId");
      } else {
        print("Store loaded successfully: ${_currentStore!.name}");
      }
    } catch (e) {
      _errorMessage = "Error loading store: $e";
      print(_errorMessage); // Debugging
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

Future<void> updateStore(Map<String, dynamic> newData,String storeId) async {
  if (storeId == null) {
    _errorMessage = "No store loaded! Load a store first.";
    notifyListeners();
    print("No store loaded to update.");
    return;
  }

  _isLoading = true;
  notifyListeners();
  
  try {
    print("Updating store with ID: ${storeId}");

    // Pass the new data to the StoreService
    await StoreService().updateStore(storeId.toString(), newData);
    
    print("Store updated with data: $newData");

    // Reload the store data to reflect changes
    await loadStoreById(storeId.toString());
  } catch (e) {
    _errorMessage = "Error updating store: $e";
    print(_errorMessage); // Debugging
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}


  // Clear store data (e.g., on logout)
  void clearStore() {
    _currentStore = null;
    notifyListeners();
  }
}
