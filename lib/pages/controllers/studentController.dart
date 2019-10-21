
import 'services.dart';
import 'dart:async';

class StudentController {
  Future<Map<String, dynamic>> show(id, token) async 
  {
     var response = Services().getData('students', id, token);
     return response;
  }
  Future<Map<String, dynamic>> update(id, data, token) async 
  {
     var response = Services().putData('students', id, data, token);
     return response;
  }
  Future<Map<String, dynamic>> create(data, token) async 
  {
     var response = Services().postData('students', data, token);
     return response;
  }
}