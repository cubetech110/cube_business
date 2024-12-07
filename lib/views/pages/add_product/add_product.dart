import 'dart:io';
import 'package:cube_business/model/product_model.dart';
import 'package:cube_business/model/user_model.dart';
import 'package:cube_business/provider/home_provider.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/services/product_screvice.dart';
import 'package:cube_business/services/upload_image_service.dart';
import 'package:cube_business/views/pages/add_product/widget/ai_text_genrator.dart';
import 'package:cube_business/views/widgets/my_background.dart';
import 'package:flutter/material.dart';
import 'package:cube_business/views/pages/add_product/widget/pick_image_product.dart';
import 'package:cube_business/views/widgets/custom_textfiled.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<File?> selectedImages = []; // Store selected images

  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();
  final productStockController = TextEditingController(); // Stock controller

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
      ),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the product name';
                          }
                          return null;
                        },
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 16),
                       productDescriptionAI(productDescriptionController:productDescriptionController),
                      const SizedBox(height: 16),
                      CustomTextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*'))
                        ],
                        label: 'Product Price',
                        hintText: 'Enter product price',
                        controller: productPriceController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the product price';
                          }
                          return null;
                        },
                        maxLines: 1,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true, signed: true),
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        label: 'Stock Quantity',
                        hintText: 'Enter stock quantity',
                        controller: productStockController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the stock quantity';
                          } else if (int.tryParse(value) == null ||
                              int.parse(value) < 0) {
                            return 'Please enter a valid stock quantity';
                          }
                          return null;
                        },
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      PickImageProduct(
                        label: 'Product Images',
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
                            onPressed: () async {
                              final productName = productNameController.text;
                              final productDescription =
                                  productDescriptionController.text;
                              final productPrice = double.tryParse(
                                      productPriceController.text) ??
                                  0.0;
                              final productStock = int.tryParse(
                                      productStockController.text) ??
                                  -1;

                              String? errorMessage;

                              if (productName.isEmpty) {
                                errorMessage = 'Product name is required.';
                              } else if (selectedImages.isEmpty) {
                                errorMessage = 'Please add product images.';
                              } else if (productPrice <= 0.0) {
                                errorMessage =
                                    'Please provide a valid product price.';
                              } else if (productStock < 0) {
                                errorMessage =
                                    'Please provide a valid stock quantity.';
                              }

                              if (errorMessage != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(errorMessage)),
                                );
                                return;
                              }

                              setState(() {
                                _isLoading = true;
                              });

                              try {
                                UserModel? currentUser =
                                    await AuthService().getCurrentUserData();
                                ProductService productService = ProductService(
                                    storeId: currentUser!.storeId!);

                                List<String> imageUrls = [];
                                for (File? imageFile in selectedImages) {
                                  if (imageFile != null) {
                                    String imageUrl =
                                        await uploadImage(imageFile);
                                    imageUrls.add(imageUrl);
                                  }
                                }

                                Product newProduct = Product(
                                  id: DateTime.now().toString(),
                                  name: productName,
                                  description: productDescription,
                                  price: productPrice,
                                  stock: productStock,
                                  category: 'm',
                                  createdAt: DateTime.now(),
                                  imageUrl: imageUrls,
                                );

                                await productService.addProduct(newProduct);
                                await homeProvider.fetchProductCount();

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Product added successfully')),
                                );

                                Navigator.pop(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Failed to add product: $e')),
                                );
                              } finally {
                                setState(() {
                                  _isLoading = false;
                                });
                              }
                            },
                            child: const Text('Add Product'),
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
