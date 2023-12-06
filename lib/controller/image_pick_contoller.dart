// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class UploadDataController extends ChangeNotifier {
//   final picker = ImagePicker();
//   File? imageFile;
//   String imageName = '';
//   String imageUrl = '';
//   final TextEditingController _controller = TextEditingController();

//   TextEditingController get controller => _controller;

//   Future<void> pickImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       imageFile = File(pickedFile.path);
//       imageName = pickedFile.name;
//       notifyListeners();
//     }
//   }

//   Future<void> uploadImage() async {
//     if (imageFile != null) {
//       final firebaseStorageRef =
//           FirebaseStorage.instance.ref().child('students/images/$imageName');

//       await firebaseStorageRef.putFile(imageFile!).whenComplete(() async {
//         imageUrl = await firebaseStorageRef.getDownloadURL();
//         notifyListeners();
//       });
//     }
//   }

//   // Future<void> uploadData() async {
//   //   var docReference = FirebaseFirestore.instance.collection('students').doc();
//   //   await docReference.set({
//   //     'title': _controller.text,
//   //     'image': imageUrl,
//   //   });
//   // }
// }