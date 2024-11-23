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
  bool _isLoading = false;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    productNameController = TextEditingController(text: widget.product.name);
    productDescriptionController =
        TextEditingController(text: widget.product.description);
    productPriceController =
        TextEditingController(text: widget.product.price.toString());

    // Initialize with product images as File objects or placeholders if necessary
    selectedImages = []; // or handle URL images appropriately
  }

  Future<void> _saveChanges() async {
    UserModel? user = await AuthService().getCurrentUserData();

    if (productNameController.text.isEmpty ||
        productDescriptionController.text.isEmpty ||
        productPriceController.text.isEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please complete all fields and add images of the product')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      List<String> imageUrls = [];
      for (File? imageFile in selectedImages) {
        if (imageFile != null) {
          String imageUrl = await uploadImage(imageFile);
          imageUrls.add(imageUrl);
        }
      }

      final documentReference = FirebaseFirestore.instance
          .collection('stores')
          .doc(user!.storeId)
          .collection('product')
          .doc(widget.product.id);

      await documentReference.update({
        'name': productNameController.text,
        'description': productDescriptionController.text,
        'price': double.parse(productPriceController.text),
        // 'imageUrl': imageUrls,
      });

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product updated successfully')),
      );

      Navigator.pop(context);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating product: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyBackground(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            const SizedBox(height: 80),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImagePageView(widget.product),
                      const SizedBox(height: 16),
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
                        label: 'Product Price',
                        hintText: 'Enter product price',
                        controller: productPriceController,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      if (!_isLoading)
                        Center(
                          child: ElevatedButton(
                            onPressed: _saveChanges,
                            child: const Text('Update Product'),
                          ),
                        ),
                    ],
                  ),
                ),
                if (_isLoading)
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(color: Colors.black),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePageView(Product product) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            itemCount: product.imageUrl.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: product.imageUrl[index] != null
                        ? NetworkImage(product.imageUrl[index]!)
                        : const AssetImage('assets/placeholder.png')
                            as ImageProvider, // Placeholder image
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        _buildPageIndicator(widget.product),
      ],
    );
  }

  Widget _buildPageIndicator(Product product) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(product.imageUrl.length, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: _currentPage == index ? 12.0 : 8.0,
          height: _currentPage == index ? 12.0 : 8.0,
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.black : Colors.grey,
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
