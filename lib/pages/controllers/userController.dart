
import 'package:fatapp/pages/controllers/abstractController.dart';
import 'dart:async';

class UserController extends AbstractController {
  Future<String> index() async {
    var response = getAllData('users');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = getData('users', id);
     return response;
  }
  Future<String> update(id, data) async 
  {
     var response = putData('users', id, data);
     return response;
  }
  Future<String> create(id, data) async 
  {
     var response = postData('users', data);
     return response;
  }
}