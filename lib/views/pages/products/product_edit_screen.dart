import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cube_business/model/product_model.dart';
import 'package:cube_business/model/user_model.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/services/upload_image_service.dart';
import 'package:cube_business/views/widgets/my_background.dart';
import 'package:flutter/material.dart';
import 'package:cube_business/views/pages/add_product/widget/pick_image_product.dart';
import 'package:cube_business/views/widgets/custom_textfiled.dart';
import 'package:flutter/services.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<File?> selectedImages = [];
  late TextEditingController productNameController;
  late TextEditingController productDescriptionController;
  late TextEditingController productPriceController;
  late TextEditingController productStockController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with product data
    productNameController = TextEditingController(text: widget.product.name);
    productDescriptionController =
        TextEditingController(text: widget.product.description);
    productPriceController =
        TextEditingController(text: widget.product.price.toString());
    productStockController =
        TextEditingController(text: widget.product.stock.toString());
  }

  Future<void> _updateProduct() async {
    final productName = productNameController.text.trim();
    final productDescription = productDescriptionController.text.trim();
    final productPrice = double.tryParse(productPriceController.text) ?? -1;
    final productStock = int.tryParse(productStockController.text) ?? -1;

    if (productName.isEmpty ||
        productDescription.isEmpty ||
        productPrice <= 0 ||
        productStock < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields correctly')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserModel? currentUser = await AuthService().getCurrentUserData();
      final productDoc = FirebaseFirestore.instance
          .collection('stores')
          .doc(currentUser!.storeId)
          .collection('product')
          .doc(widget.product.id);

      List imageUrls = widget.product.imageUrl;

      // Upload new images if added
      for (File? imageFile in selectedImages) {
        if (imageFile != null) {
          String imageUrl = await uploadImage(imageFile);
          imageUrls.add(imageUrl);
        }
      }

      // Update product details
      await productDoc.update({
        'name': productName,
        'description': productDescription,
        'price': productPrice,
        'stock': productStock,
        'imageUrl': imageUrls,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product updated successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update product: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Update Product')),
      body: MyBackground(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: 'Product Name',
                        hintText: 'Enter product name',
                        controller: productNameController,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: 'Product Description',
                        hintText: 'Enter product description',
                        controller: productDescriptionController,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*')),
                        ],
                        label: 'Product Price',
                        hintText: 'Enter product price',
                        controller: productPriceController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                          signed: false,
                        ),
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        label: 'Stock Quantity',
                        hintText: 'Enter stock quantity',
                        controller: productStockController,
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 16),
                      PickImageProduct(
                        label: 'Update Images',
                        onImagesPicked: (files) {
                          setState(() {
                            selectedImages = files;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      if (!_isLoading)
                        Center(
                          child: ElevatedButton(
                            onPressed: _updateProduct,
                            child: const Text('Update Product'),
                          ),
                        ),
                    ],
                  ),
                ),
                if (_isLoading)
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
