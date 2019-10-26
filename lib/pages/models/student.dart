import 'package:fatapp/pages/models/course.dart';
import 'package:fatapp/pages/models/user.dart';

class Student extends User {
  int id;
  int ra;
  String token;
  Course course;
  User user;
  
  Student({this.token, this.id, this.ra, this.course, this.user});

  Student.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['student']['id'];
    ra = json['student']['ra'];
    course = Course.fromJson(json['course']);
    user = User.fromJson(json['user'], token);
  }
}