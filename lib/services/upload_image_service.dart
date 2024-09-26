import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

Future<String> uploadImage(File image) async {
  // Load the image using the image package
  final originalImage = img.decodeImage(image.readAsBytesSync())!;
  
  // Resize the image to a desired size
  final resizedImage = img.copyResize(originalImage, width: 400);

  // Convert the resized image back to a file with lower quality
  final tempDir = await getTemporaryDirectory();
  final tempFile = File('${tempDir.path}/${FirebaseAuth.instance.currentUser!.uid}_resized.jpg')
    ..writeAsBytesSync(img.encodeJpg(resizedImage, quality: 50)); // Reduced quality to 50

  // Upload the resized image
  final ref = FirebaseStorage.instance
      .ref()
      .child('images')
      .child('${FirebaseAuth.instance.currentUser!.uid}.jpg');

  await ref.putFile(tempFile);
  return await ref.getDownloadURL();
}
