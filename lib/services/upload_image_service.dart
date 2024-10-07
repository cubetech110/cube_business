import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';

Future<String> uploadImage(File imageFile) async {
  /// Generate a hash (checksum) for a file to detect duplicates
  Future<String> generateFileHash(File file) async {
    final bytes = await file.readAsBytes();
    final digest = sha256.convert(bytes); // You can use sha256 or another algorithm
    return digest.toString();
  }

  /// Compress the image using the `image` package
  Future<File> compressImage(File file) async {
    // Read the image from the file
    img.Image? originalImage = img.decodeImage(file.readAsBytesSync());

    // Resize the image to reduce its size
    img.Image resizedImage = img.copyResize(originalImage!, width: 800); // Resize to width 800px

    // Get the temporary directory for storing the compressed image
    final directory = await getTemporaryDirectory();
    final compressedImagePath = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final compressedImageFile = File(compressedImagePath);

    // Save the resized image with reduced quality (0-100 scale)
    await compressedImageFile.writeAsBytes(img.encodeJpg(resizedImage, quality: 85)); // 85% quality

    return compressedImageFile;
  }

  // Step 1: Compress the image before uploading
  File compressedImage = await compressImage(imageFile);

  // Step 2: Generate a file hash to use as a unique identifier
  String fileHash = await generateFileHash(compressedImage);
  String fileName = "$fileHash.jpg"; // Use the hash as the filename

  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child('products/$fileName');

  // Step 3: Check if the file already exists by checking the download URL
  try {
    String existingUrl = await ref.getDownloadURL();
    print('Image already exists at: $existingUrl');
    return existingUrl; // Return the existing URL if found
  } catch (e) {
    // Step 4: If the file doesn't exist, upload the compressed image
    UploadTask uploadTask = ref.putFile(compressedImage);
    TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
    return await snapshot.ref.getDownloadURL(); // Return the new URL after upload
  }
}
