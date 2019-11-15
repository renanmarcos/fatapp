import 'package:fatapp/pages/models/student.dart';

class User {
  int id;
  String name;
  String email;
  String cpf;
  String password;
  String token;
  Student student;

  User(
      {this.token,
      this.id,
      this.name,
      this.email,
      this.cpf,
      this.password,
      this.student});

  User.create(Map<String, dynamic> json) {
    this.token = json['token'];
    this.id = json['user']['id'];
    this.name = json['user']['name'];
    this.email = json['user']['email'];
    this.cpf = json['user']['cpf'];
    this.password = json['user']['password'];

    if (json['user']['student'] != null) {
      this.student = Student.fromUser(json['user']['student']);
    }
  }

  User.fromJson(Map<String, dynamic> json, String token) {
    this.token = token;
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.cpf = json['cpf'];
    this.password = json['password'];
  }

  User.fromStudent(Map<String, dynamic> json, String token) {
    this.token = token;
    this.id = json['user']['id'];
    this.name = json['user']['name'];
    this.email = json['user']['email'];
    this.cpf = json['user']['cpf'];
    this.password = json['user']['password'];
    this.student = Student.fromUser(json);
  }
  User.createWithStudent(Map<String, dynamic> json) {
    this.token = json['token'];
    this.id = json['student']['user']['id'];
    this.name = json['student']['user']['name'];
    this.email = json['student']['user']['email'];
    this.cpf = json['student']['user']['cpf'];
    this.password = json['student']['user']['password'];
    this.student = Student.fromUser(json['student']);
  }
}
