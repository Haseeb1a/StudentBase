import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentapp/model/student_model.dart';

class StudentFirebaseService {
  final CollectionReference student =
      FirebaseFirestore.instance.collection('students');

  //  fetch students
  Future<List<StudentModel>> getSudents() async {
    final snapshot = await student.orderBy('name').get();
    return snapshot.docs.map((doc) {
      return StudentModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // add stdents
  addSudents(name, roll, image, stand) {
    final data = StudentModel(
      name: name,
      roll: roll,
      image: image,
      stand: stand,
    ).toMap();
    student.add(data);
  }

  // delete  Sudent
  deleteSudents(docId) {
    student.doc(docId).delete();
  }

  // update Students
  updateStudents(name, roll, image, stand, id) {
    final data = StudentModel(
      name: name,
      roll: roll,
      image: image,
      stand: stand,
    ).toMap();
    student.doc(id).update(data);
  }
}
