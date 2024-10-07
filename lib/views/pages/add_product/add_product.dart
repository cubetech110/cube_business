import 'dart:io';
import 'package:cube_business/model/product_model.dart';
import 'package:cube_business/model/user_model.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/services/product_screvice.dart';
import 'package:cube_business/services/upload_image_service.dart';
import 'package:cube_business/views/widgets/my_background.dart';
import 'package:flutter/material.dart';
import 'package:cube_business/views/pages/add_product/widget/pick_image_product.dart';
import 'package:cube_business/views/widgets/custom_textfiled.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<File?> selectedImages = []; // تخزين الصور المختارة

  // TextEditingControllers لإدارة إدخال النصوص
  final productNameController = TextEditingController();
  final productDescriptionController = TextEditingController();
  final productPriceController = TextEditingController();

  bool _isLoading = false; // حالة للتحكم في عرض وإخفاء المؤشر

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      label: 'اسم المنتج',
                      hintText: 'أدخل اسم المنتج',
                      controller: productNameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال اسم المنتج';
                        }
                        return null;
                      },
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: 'وصف المنتج',
                      hintText: 'أدخل وصفاً للمنتج',
                      controller: productDescriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال وصف المنتج';
                        }
                        return null;
                      },
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: 'سعر المنتج',
                      hintText: 'أدخل سعر المنتج',
                      controller: productPriceController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'يرجى إدخال سعر المنتج';
                        }
                        return null;
                      },
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),
                    PickImageProduct(
                      label: 'صور المنتج',
                      onImagesPicked: (files) {
                        setState(() {
                          selectedImages = files; // تخزين الصور المختارة
                        });
                        print('عدد الصور المختارة: ${selectedImages.length}');
                      },
                    ),
                    const SizedBox(height: 16),
                    if (!_isLoading) // عرض الزر إذا لم يكن هناك تحميل
                       Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            final productName = productNameController.text;
                            final productDescription = productDescriptionController.text;
                            final productPrice = double.tryParse(productPriceController.text) ?? 0.0;
          
                            if (productName.isEmpty || productDescription.isEmpty || productPrice <= 0 || selectedImages.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('يرجى إكمال جميع الحقول وإضافة صور للمنتج'),
                                ),
                              );
                              return;
                            }
          
                            setState(() {
                              _isLoading = true; // إظهار المؤشر
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
                              _isLoading = false; // إخفاء المؤشر
                            });
          
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('تم إضافة المنتج بنجاح'),
                              ),
                            );
          
                            Navigator.pop(context); // العودة إلى الشاشة السابقة بعد الإضافة
                          },
                          child: const Text('إضافة المنتج'),
                        ),
                      ),
                  ],
                ),
              ),
              if (_isLoading)
                const Align(
                  alignment: Alignment.bottomCenter,
                  child: LinearProgressIndicator(color: Colors.black,), // مؤشر التقدم الأفقي
                ),
            ],
          ),
        ],
      ),
    ));
  }
}
