import 'package:cube_business/provider/user_provider.dart';
import 'package:cube_business/provider/store_provider.dart';
import 'package:cube_business/services/upload_image_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import Image Picker
import 'package:provider/provider.dart'; // Import Provider
import 'dart:io'; // For File

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage; // Store the selected image
  TextEditingController _emailController = TextEditingController();
  bool _isLoading = false; // Add loading state

  @override
  Widget build(BuildContext context) {
    // Access the UserProvider and StoreProvider data
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          _isLoading
              ? const Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 30,
                  width: 30,
                    child: CircularProgressIndicator(
                      color: Colors.black, // Loading indicator while saving
                    ),
                  ),
              )
              : IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    // Save the updated email and profile image (if any)
                    _saveProfile(context);
                  },
                ),
        ],
      ),
      body: Consumer2<UserProvider, StoreProvider>(
        builder: (context, userProvider, storeProvider, child) {
          // If the data is still loading, show a loading indicator
          if (userProvider.currentUser == null || userProvider.currentStore == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Initialize email controller with current user email
          _emailController.text = userProvider.currentUser!.email ?? '';

          // When data is available, show the profile screen
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Information
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => _pickImage(), // Pick a new profile image
                          child: CircleAvatar(
                            radius: 40,
                            backgroundImage: _selectedImage != null
                                ? FileImage(_selectedImage!) // Display the new selected image
                                : NetworkImage(userProvider.currentStore!.logoUrl!) as ImageProvider, // Display existing image if available
                            child: _selectedImage == null
                                ? const Icon(Icons.camera_alt, color: Colors.white) // Icon for editing
                                : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userProvider.currentStore!.name ?? 'Unknown Name',
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            // SizedBox(
                            //   width: 250, // Set width for TextField
                            //   child: TextField(
                            //     controller: _emailController,
                            //     decoration: InputDecoration(
                            //       labelText: 'البريد الالكتروني',
                            //       filled: true, // Fill the background color
                            //       fillColor: Colors.grey[200], // Set a light background color
                            //       contentPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2), // Reduce padding
                            //       border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(20), // Reduced border radius
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: 8),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Status section
                    const Text(
                      'القوالب',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildStatusButton('تقليدي', Colors.black),
                        _buildStatusButton('ملابس', Colors.red),
                        _buildStatusButton('أغذية', Colors.orange),
                        _buildStatusButton('تجميل', Colors.blue),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Method to build status button
  Widget _buildStatusButton(String title, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Pick image using ImagePicker
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery); // Pick from gallery
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path); // Store the selected image
      });
    }
  }

  // Save profile changes
Future<void> _saveProfile(BuildContext context) async {
  setState(() {
    _isLoading = true;
  });

  final userProvider = Provider.of<UserProvider>(context, listen: false);
  final storeProvider = Provider.of<StoreProvider>(context, listen: false);

  try {
    // Update email
    final newEmail = _emailController.text.trim();
    if (newEmail.isNotEmpty && newEmail != userProvider.currentUser!.email) {
      await userProvider.updateEmail(newEmail); // Implement this method in UserProvider
    }

    // Update profile image (store logo)
    if (_selectedImage != null) {
      // Ensure uploadImage is working correctly
      String logoUrl = await uploadImage(_selectedImage!);

      // Update store with the new logo URL
      await storeProvider.updateStore({'logoUrl': logoUrl}, userProvider.currentUser!.storeId.toString());

storeProvider.loadStoreById(userProvider.currentUser!.storeId.toString());
userProvider.loadCurrentUser();


    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully')));
  } catch (e) {
    print("Error during profile update: $e");
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Error updating profile')));
  } finally {
    setState(() {
      _isLoading = false;
    });
  }}
}
