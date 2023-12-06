
import 'package:flutter/material.dart';
import 'package:studentapp/model/donor_model.dart';
import 'package:studentapp/services/donor_service.dart';

class Homecontroller extends ChangeNotifier {
  List<StudentModel> donorDatas = [];
  // getDonors
  Future<void> fecthDonorDatas() async {
    donorDatas = await DonorFirebaseService().getDonors();
    notifyListeners();
  }

  // deletedonors
  deleteSudent(docId) async {
    await DonorFirebaseService().deleteSudents(docId);
    fecthDonorDatas();
    notifyListeners();
  }
}
