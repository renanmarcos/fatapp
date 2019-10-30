import 'package:fatapp/pages/models/student.dart';

class User {
  int id;
  String name;
  String email;
  String cpf;
  String password;
  String token;
  Student student;

  User({this.token, this.id, this.name, this.email, this.cpf, this.password, this.student});

  User.create(Map<String, dynamic> json) {
    token = json['token'];
    id = json['user']['id'];
    name = json['user']['name'];
    email = json['user']['email'];
    cpf = json['user']['cpf'];
    password = json['user']['password'];
    student = Student(id: json['user']['student']['id'], ra: json['user']['student']['ra']);
  }
  User.fromJson(Map<String, dynamic> json, String token) {
    token = token;
    id = json['id'];
    name = json['name'];
    email = json['email'];
    cpf = json['cpf'];
    password = json['password'];
  }
}