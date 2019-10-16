
import 'services.dart';
import 'dart:async';

class UserController {
  Future<String> index() async {
    var response = Services().getAllData('users');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = Services().getData('users', id);
     return response;
  }
  Future<String> update(id, data) async 
  {
     var response = Services().putData('users', id, data);
     return response;
  }
  Future<String> create(id, data) async 
  {
     var response = Services().postData('users', data);
     return response;
  }
}