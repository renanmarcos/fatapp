import 'package:fatapp/pages/models/course.dart';
import 'package:fatapp/pages/models/user.dart';

class Student extends User {
  int id;
  String ra;
  String token;
  Course course;
  User user;

  Student({this.token, this.id, this.ra, this.course, this.user});

  Student.fromJson(Map<String, dynamic> json) {
    this.token = json['token'];
    this.id = json['student']['id'];
    this.ra = json['student']['ra'];
    this.course = Course.fromJson(json['course']);
    this.user = User.fromJson(json['user'], token);
  }
}
