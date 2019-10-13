class Student {
  int id;
  int ra;
  String course;
  
  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ra = json['ra'];
    course = json['course'];
  }
}