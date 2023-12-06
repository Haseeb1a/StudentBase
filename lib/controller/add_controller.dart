import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:studentapp/controller/home_controller.dart';
import 'package:studentapp/helpers/images.dart';
import 'package:studentapp/services/donor_service.dart';

class AddController extends ChangeNotifier {
  //  UploadDataController profileData = UploadDataController();
  Homecontroller homeData = Homecontroller();
  TextEditingController nameController = TextEditingController();
  TextEditingController rollController = TextEditingController();
  // TextEditingController numberController = TextEditingController();
  final List divisions = [
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
  String? selectedDivision;

  // image contolleres

  final picker = ImagePicker();
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
        notifyListeners();
        addSudent(imageUrl);
        print(imageUrl);
        imageUrl = '';
        imageFile = null;
        notifyListeners();
      });
    } else {
      addSudent(defaultImage);
    }
  }

  void addSudent(imageUrl) {
    print(imageUrl);
    print(rollController.text);
    print(nameController.text);
    DonorFirebaseService().addSudents(
      nameController.text,
      rollController.text,
      imageUrl,
      selectedDivision,
    );
    homeData.donorDatas;
    notifyListeners();
    nameController.clear();
    rollController.clear();
  }
}
