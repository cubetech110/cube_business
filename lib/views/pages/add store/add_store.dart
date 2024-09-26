import 'dart:io';
import 'package:cube_business/core/catogery_type.dart';
import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/model/store_model.dart';
import 'package:cube_business/services/store_service.dart';
import 'package:cube_business/services/upload_image_service.dart';
import 'package:cube_business/views/pages/add%20store/widgets/pick_image_strore.dart';
import 'package:cube_business/views/pages/home/home_screen.dart';
import 'package:cube_business/views/widgets/custom_b.dart';
import 'package:cube_business/views/widgets/custom_dropdown.dart';
import 'package:cube_business/views/widgets/custom_textfiled.dart';
import 'package:cube_business/views/widgets/my_background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EnterDetailsScreen extends StatefulWidget {
  const EnterDetailsScreen({super.key});

  @override
  _EnterDetailsScreenState createState() => _EnterDetailsScreenState();
}

class _EnterDetailsScreenState extends State<EnterDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _storeNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  CategoryType? _selectedStoreType;
  bool _isLoading = false;
  File? _imageFile;
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyBackground(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 600),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: PickImageStore(
                          onImagePicked: (file) {
                            setState(() {
                              _imageFile = file;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildStoreNameField(),
                      const SizedBox(height: 20),
                      // _buildEmailField(),
                      // const SizedBox(height: 20),
                      _buildStoreTypeDropdown(),
                      const SizedBox(height: 40),
                      _buildSubmitButton(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStoreNameField() {
    return CustomTextField(
      label: 'اسم المتجر',
      hintText: 'أدخل اسم المتجر',
      controller: _storeNameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال اسم المتجر';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      label: 'البريد الإلكتروني',
      hintText: 'أدخل البريد الإلكتروني',
      controller: _emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال البريد الإلكتروني';
        }
        return null;
      },
    );
  }

  Widget _buildStoreTypeDropdown() {
    return CustomDropdown(
      label: 'نوع المتجر',
      hintText: 'اختر نوع متجرك',
      items: CategoryType.values,
      selectedItem: _selectedStoreType,
      onChanged: (CategoryType? newValue) {
        setState(() {
          _selectedStoreType = newValue;
        });
      },
    );
  }

  Widget _buildSubmitButton() {
    return _isLoading
        ? const Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(),
            ),
          )
        : CustomButton(
            text: 'تفضل متجرك!',
            onPressed: _submitForm,
          );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedStoreType == null) {
        _showErrorSnackBar('الرجاء اختيار نوع المتجر');
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        if (_imageFile != null) {
          _imageUrl = await uploadImage(_imageFile!);
        }

        // String id;
        // String name;
        // String ownerId;
        // String location;
        // DateTime createdAt;
        // int visitorCount;
        // String categories;

        Store store = Store(
          categories: _selectedStoreType.toString(),
          createdAt: DateTime.now(),
          name: _storeNameController.text,
          visitorCount: 0,
          ownerId:FirebaseAuth.instance.currentUser!.uid,
          location: '',
          logoUrl: _imageUrl
        );

        await StoreService().addStore(store);
      } catch (e) {
        _showErrorSnackBar(e.toString());
      } finally {
        setState(() {
          navigateAndRemove(context, HomeScreen());
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
