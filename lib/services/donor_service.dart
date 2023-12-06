import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentapp/model/donor_model.dart';

class DonorFirebaseService {
  final CollectionReference student =
      FirebaseFirestore.instance.collection('students');

  // donor fetch
  Future<List<StudentModel>> getDonors() async {
    final snapshot = await student.orderBy('name').get();
    return snapshot.docs.map((doc) {
      return StudentModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // addd donor
  addSudents(name, phone, image ,stand) {
    final data = StudentModel(name: name, roll: phone, image: image,
    stand: stand,
    ).toMap();
    student.add(data);
  }

  // delete  Sudent
  deleteSudents(docId) {
    student.doc(docId).delete();
  }

  // update Students
  updateStudents(name, phone, image ,stand, id) {
     final data = StudentModel(name: name, roll: phone, image: image,
    stand: stand,
    ).toMap();
    student.doc(id).update(data);
  }
}
