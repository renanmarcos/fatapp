import 'dart:convert';

class Student {
  int id;
  int ra;
  String course;
  
  Student({this.id, this.ra, this.course});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ra = json['ra'];
    course = json['course'];
  }
  List<Student> studentList(String body) {
    final list = json.decode(body).cast<Map<String, dynamic>>();
    return list.map<Student>((json) => Student.fromJson(json)).toList();
  }
}