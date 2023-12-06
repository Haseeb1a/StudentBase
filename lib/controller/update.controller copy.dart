import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentapp/controller/home_controller.dart';
import 'package:studentapp/services/donor_service.dart';

class UpdateController extends ChangeNotifier {
  Homecontroller homeData = Homecontroller();
  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  final List divistions = [
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
    'VIII',
    'IX',
    ' X '
  ];

  // 
  String? selectedDivison;

  final picker = ImagePicker();

  String id = '';
  File? imageFile;
  String imageName = '';
  String imageUrl = '';
  final TextEditingController _controller = TextEditingController();

  TextEditingController get controller => _controller;

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      imageName = pickedFile.name;
     notifyListeners();
    }
  }

  Future<void> uploadImage() async {
    if (imageFile != null) {
      final firebaseStorageRef =
          FirebaseStorage.instance.ref().child('students/images/$imageName');

      await firebaseStorageRef.putFile(imageFile!).whenComplete(() async {
        imageUrl = await firebaseStorageRef.getDownloadURL();
        updateStudent(id, imageUrl);
        imageUrl = '';
        imageFile = null;
        print(imageUrl);
        notifyListeners();
      });
    }else{
      updateStudent(id, imageUrl);
      imageUrl = '';
      imageFile = null;
    }
  }

  // updateHonors
  updateStudent(docId, imageUrl) async {
    await DonorFirebaseService().updateStudents(nameController.text,
        rollController.text, imageUrl, selectedDivison, docId);
    homeData.donorDatas;
    notifyListeners();
  }
}
