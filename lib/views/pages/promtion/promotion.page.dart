import 'dart:io';
import 'package:cube_business/model/store_model.dart';
import 'package:cube_business/model/user_model.dart';
import 'package:cube_business/services/auth_service.dart';
import 'package:cube_business/services/store_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class PromotionPage extends StatefulWidget {
  const PromotionPage({Key? key}) : super(key: key);

  @override
  _PromotionPageState createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  bool _isUploading = false;
  bool _isLoading = true; // New variable to track loading state
  Store? currentStore;

  @override
  void initState() {
    super.initState();
    _loadCurrentStore();
  }

  Future<void> _loadCurrentStore() async {
    setState(() {
      _isLoading = true; // Set loading to true when loading starts
    });

    UserModel? currentUser = await AuthService().getCurrentUserData();
    if (currentUser != null && currentUser.storeId != null) {
      currentStore = await StoreService().getStoreById(currentUser.storeId!);
    }

    setState(() {
      _isLoading = false; // Set loading to false when loading completes
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    UserModel? currentUser = await AuthService().getCurrentUserData();
    if (currentUser == null || currentUser.storeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: User or store not found')),
      );
      return;
    }

    if (_selectedImage == null) return;

    setState(() {
      _isUploading = true;
    });

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('promotions/${DateTime.now().toIso8601String()}');
      await storageRef.putFile(_selectedImage!);
      final downloadUrl = await storageRef.getDownloadURL();

      await StoreService().updateStore(currentUser.storeId!, {'premotionUrl': downloadUrl});

      currentStore = await StoreService().getStoreById(currentUser.storeId!);
      setState(() {}); // Update UI with the latest store data

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload successful!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store Promotion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _selectedImage != null
                ? Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            _selectedImage!,
                            height: 200,
                            width: 400,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 10,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _selectedImage = null;
                            });
                          },
                          icon: Icon(Icons.close),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey[350],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              Icons.image,
                              size: 50,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _isLoading
                          ? const CircularProgressIndicator() // Show loading indicator if data is loading
                          : currentStore?.premotionUrl != null
                              ? Column(
                                  children: [
                                    Text(
                                      'Current Promotion:',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20),
                                        child: Image.network(
                                          currentStore!.premotionUrl!,
                                          height: 200,
                                          width: 400,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(), // Hide if there's no promotion
                    ],
                  ),
            const SizedBox(height: 10),
            _isUploading
                ? const CircularProgressIndicator()
                : _selectedImage != null
                    ? ElevatedButton(
                        onPressed: _uploadImage,
                        child: const Text('Upload Promotion'),
                      )
                    : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
