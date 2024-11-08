import 'dart:io';
import 'package:cube_business/model/product_model.dart';
import 'package:cube_business/model/user_model.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/services/product_screvice.dart';
import 'package:cube_business/services/upload_image_service.dart';
import 'package:cube_business/views/pages/add_product/widget/ai_text_genrator.dart';
import 'package:cube_business/views/widgets/my_background.dart';
import 'package:flutter/material.dart';
import 'package:cube_business/views/pages/add_product/widget/pick_image_product.dart';
import 'package:cube_business/views/widgets/custom_textfiled.dart';
import 'package:flutter/services.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<File?> selectedImages = []; // Store selected images

  // TextEditingControllers to manage text input
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();

  bool _isLoading = false; // State to control loading indicator visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MyBackground(
        child: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            const SizedBox(height: 120,),
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
productDescriptionAI(),                    const SizedBox(height: 16),
                    CustomTextField(
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],

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
                      keyboardType: TextInputType.numberWithOptions(decimal: true,signed: true),
                    ),
                    const SizedBox(height: 16),
                    PickImageProduct(
                      label: 'Product Images',
                      onImagesPicked: (files) {
                        setState(() {
                          selectedImages = files; // Store selected images
                        });
                        print('Number of selected images: ${selectedImages.length}');
                      },
                    ),
                    const SizedBox(height: 16),
                    if (!_isLoading) // Show button if not loading
                       Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            final productName = productNameController.text;
                            final productDescription = productDescriptionController.text;
                            final productPrice = double.tryParse(productPriceController.text) ?? 0.0;
          
                            if (productName.isEmpty || productDescription.isEmpty  || selectedImages.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill in all fields and add product images'),
                                ),
                              );
                              return;
                            }
          
                            setState(() {
                              _isLoading = true; // Show loading indicator
                            });
          
                            UserModel? currentUser = await AuthService().getCurrentUserData();
                            ProductService productService = ProductService(storeId: currentUser!.storeId!);
          
                            // Upload images and get URLs
                            List<String> imageUrls = [];
                            // Inside the upload function
                            for (File? imageFile in selectedImages) {
                              if (imageFile != null) {
                                print('Uploading image: ${imageFile.path}'); // Log the path to check if duplicates exist
                                String imageUrl = await uploadImage(imageFile);
                                imageUrls.add(imageUrl);
                              }
                            }
          
                            // Create the product with the image URLs
                            Product newProduct = Product(
                              id: DateTime.now().toString(),
                              name: productName,
                              description: productDescription,
                              price: productPrice,
                              stock: 100,
                              category: 'm',
                              createdAt: DateTime.now(),
                              imageUrl: imageUrls, // Assign the URLs here
                            );
          
                            await productService.addProduct(newProduct);
          
                            setState(() {
                              _isLoading = false; // Hide loading indicator
                            });
          
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Product added successfully'),
                              ),
                            );
          
                            Navigator.pop(context); // Navigate back after adding product
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
                  child: LinearProgressIndicator(color: Colors.black,), // Horizontal progress indicator
                ),
            ],
          ),
        ],
      ),
    ));
  }
}
