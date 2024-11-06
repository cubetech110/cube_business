import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PickImageStore extends StatefulWidget {
  final ValueChanged<File?> onImagePicked;

  const PickImageStore({super.key, required this.onImagePicked});

  @override
  _PickImageStoreState createState() => _PickImageStoreState();
}

class _PickImageStoreState extends State<PickImageStore> {
  XFile? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    widget.onImagePicked(_image != null ? File(_image!.path) : null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.grey,
                width: 2,
              ),
              image: _image != null
                  ? DecorationImage(
                      image: FileImage(File(_image!.path)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: _image == null
                ? Center(
                    child: Image.asset(
                      'assets/image/store-alt.png',
                      width: 40,
                      color: Colors.grey[600],
                    ),
                  )
                : null,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'click to pick logo',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
