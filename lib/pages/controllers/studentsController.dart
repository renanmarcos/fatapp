
import 'package:fatapp/pages/controllers/abstractController.dart';
import 'dart:async';

class StudentsController extends AbstractController {
  Future<String> index() async {
    var response = getAllData('students');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = getData('students', id);
     return response;
  }
  Future<String> update(id, data) async 
  {
     var response = putData('students', id, data);
     return response;
  }
  Future<String> create(id, data) async 
  {
     var response = postData('students', data);
     return response;
  }
}