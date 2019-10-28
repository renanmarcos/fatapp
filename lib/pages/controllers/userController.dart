
import 'services.dart';
import 'dart:async';

class UserController {
  Future<dynamic> show(id, token) async 
  {
     final response = Services().getData('users', id, token);
     return response;
  }
  Future<dynamic> update(id, data, token) async 
  {
     final response = Services().putData('users', id, data, token);
     return response;
  }
  Future<dynamic> login(data) async 
  {
     final response = Services().postData('auth/token', data, null);
     return response;
  }
  Future<dynamic> create(data) async 
  {
     final response = Services().postData('users', data, null);
     return response;
  }
}