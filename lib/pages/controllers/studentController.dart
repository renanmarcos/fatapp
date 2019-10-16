
import 'services.dart';
import 'dart:async';

class StudentController {
  Future<String> index() async {
    var response = Services().getAllData('students');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = Services().getData('students', id);
     return response;
  }
  Future<String> update(id, data) async 
  {
     var response = Services().putData('students', id, data);
     return response;
  }
  Future<String> create(id, data) async 
  {
     var response = Services().postData('students', data);
     return response;
  }
}