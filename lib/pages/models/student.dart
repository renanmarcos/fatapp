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
    token = json['token'];
    id = json['student']['id'];
    ra = json['student']['ra'];
    course = Course.fromJson(json['student']['course']);
    user = User.fromJson(json['student']['user'], token);
  }
  Student.fromUser(Map<String, dynamic> json) {
    id = json['id'];
    ra = json['ra'];
  }
}