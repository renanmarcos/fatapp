
import 'package:fatapp/pages/controllers/services.dart';
import 'dart:async';

class StudentsController  {
  Future<String> index(token) async {
    var response = Services().getAllData('students', token);
    return response;
  }
  Future<String> show(id, token) async 
  {
     var response = Services().getData('students', id, token);
     return response;
  }
  Future<String> update(id, data, token) async 
  {
     var response = Services().putData('students', id, data, token);
     return response;
  }
  Future<String> create(id, data) async 
  {
     var response = Services().postData('students', data, null);
     return response;
  }
}