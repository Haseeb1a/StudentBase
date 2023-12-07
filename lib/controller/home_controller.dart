
import 'package:flutter/material.dart';
import 'package:studentapp/model/student_model.dart';
import 'package:studentapp/services/students_service.dart';

class Homecontroller extends ChangeNotifier {
  List<StudentModel> studentDatas = [];
  // getstudent
  Future<void> fecthDonorDatas() async {
    studentDatas = await StudentFirebaseService().getSudents();
    notifyListeners();
  }

  // deletestudent
  deleteSudent(docId) async {
    await StudentFirebaseService().deleteSudents(docId);
    fecthDonorDatas();
    notifyListeners();
  }
}
