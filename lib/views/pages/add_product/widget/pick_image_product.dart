import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// ignore: must_be_immutable
class PickImageProduct extends StatefulWidget {
  final ValueChanged<List<File?>> onImagesPicked;
  String label;

  PickImageProduct({super.key, required this.onImagesPicked, required this.label});

  @override
  _PickImageProductState createState() => _PickImageProductState();
}

class _PickImageProductState extends State<PickImageProduct> {
  List<XFile?> _images = [];

  Future<void> _pickImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile?> pickedImages = await picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _images = pickedImages;
      });
      widget.onImagesPicked(_images.map((image) => image != null ? File(image.path) : null).toList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            GestureDetector(
              onTap: _pickImages,
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
                ),
                child: Center(
                  child: Icon(
                    Icons.add_a_photo,
                    size: 30,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _images.map((image) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          ),
                          image: image != null
                              ? DecorationImage(
                                  image: FileImage(File(image.path)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
