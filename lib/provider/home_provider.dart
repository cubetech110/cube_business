import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/services/product_screvice.dart';
import 'package:cube_business/model/user_model.dart';

class HomeProvider with ChangeNotifier {
  String productCount = "0";
  bool isLoading = true;
  int _animationCounter = 0;
  Timer? _timer;

  HomeProvider() {
    startLoadingAnimation();
    fetchProductCount();
  }

  void startLoadingAnimation() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      _animationCounter++;
      productCount = (_animationCounter % 100).toString(); // Animated number
      notifyListeners();
    });
  }

  Future<void> fetchProductCount() async {
    UserModel? currentUser = await AuthService().getCurrentUserData();
    if (currentUser != null) {
      ProductService productService = ProductService(storeId: currentUser.storeId!);
      int count = await productService.countProducts();
      _timer?.cancel(); // Stop the animation once data is loaded
      productCount = count.toString(); // Update the product count
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
