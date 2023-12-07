class StudentModel {
  String? id;
  String? name;
  String? roll;
  String? stand;
  String? image;
  StudentModel({
    this.id = '',
    required this.name,
    required this.roll,
    required this.image,
    required this.stand,
  });
  // set to model
  factory StudentModel.fromMap(Map<String, dynamic> map, id) {
    return StudentModel(
        name: map['name'], roll: map['roll'], image: map['image'],stand: map['stand'], id: id);
  }
  // get from the model
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      "roll": roll,
      "image": image,
      'stand':stand,
    };
  }
}
