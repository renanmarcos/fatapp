
import 'services.dart';
import 'dart:async';

class StudentController {
  Future<dynamic> show(id, token) async 
  {
     var response = Services().getData('students', id, token);
     return response;
  }
  Future<dynamic> update(id, data, token) async 
  {
     var response = Services().putData('students', id, data, token);
     return response;
  }
  Future<dynamic> create(data) async 
  {
     var response = Services().postData('students', data, null);
     return response;
  }
}