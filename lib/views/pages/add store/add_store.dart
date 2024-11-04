import 'dart:io';
import 'package:cube_business/core/catogery_type.dart';
import 'package:cube_business/core/helper/nav_helper.dart';
import 'package:cube_business/model/store_model.dart';
import 'package:cube_business/provider/user_provider.dart';
import 'package:cube_business/services/store_service.dart';
import 'package:cube_business/services/upload_image_service.dart';
import 'package:cube_business/views/pages/add%20store/widgets/pick_image_strore.dart';
import 'package:cube_business/views/pages/auth/login_screen.dart';
import 'package:cube_business/views/pages/home/home_screen.dart';
import 'package:cube_business/views/widgets/custom_b.dart';
import 'package:cube_business/views/widgets/custom_dropdown.dart';
import 'package:cube_business/views/widgets/custom_textfiled.dart';
import 'package:cube_business/views/widgets/my_background.dart';
import 'package:cube_business/views/widgets/show_msg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final userProvider = Provider.of<UserProvider>(context);

    // Show loading indicator while loading
    if (userProvider.isLoading) {
      return Scaffold(
        backgroundColor: Colors.grey[100],
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final currentUser = userProvider.currentUser;

    // If the currentUser or storeId is null, navigate to EnterDetailsScreen
    if (currentUser == null) {
      return LoginScreen();
    }

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
      label: 'Store Name',
      hintText: 'Enter store name',
      controller: _storeNameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the store name';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return CustomTextField(
      label: 'Email',
      hintText: 'Enter email address',
      controller: _emailController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email address';
        }
        return null;
      },
    );
  }

  Widget _buildStoreTypeDropdown() {
    return CustomDropdown(
      label: 'Store Type',
      hintText: 'Select your store type',
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
            text: 'Submit Your Store!',
            onPressed: _submitForm,
          );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedStoreType == null) {
        showErrorSnackBar('Please select a store type', context);
        return;
      }

      // Check if an image is selected, if not, show an error
      if (_imageFile == null) {
        showErrorSnackBar('Please choose an image for the store', context);
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        // Upload image and get the URL
        if (_imageFile != null) {
          _imageUrl = await uploadImage(_imageFile!);
        }

        // Create a new store object
        Store store = Store(
          categories: _selectedStoreType.toString(),
          createdAt: DateTime.now(),
          name: _storeNameController.text,
          visitorCount: 0,
          ownerId: FirebaseAuth.instance.currentUser!.uid,
          location: '',
          logoUrl: _imageUrl, // Use the uploaded image URL
        );

        // Add the store to the database
        await StoreService().addStore(store);

        // Navigate to HomeScreen after successful store creation
        navigateAndRemove(context, HomeScreen());
      } catch (e) {
        showErrorSnackBar(e.toString(), context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
