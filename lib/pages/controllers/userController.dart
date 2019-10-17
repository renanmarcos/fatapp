
import 'services.dart';
import 'dart:async';

class UserController {
  Future<String> show(id, token) async 
  {
     final response = Services().getData('users', id, token);
     return response;
  }
  Future<String> update(id, data, token) async 
  {
     final response = Services().putData('users', id, data, token);
     return response;
  }
  Future<String> login(data) async 
  {
     final response = Services().postData('auth/token', data, null);
     return response;
  }
  Future<String> create(data) async 
  {
     final response = Services().postData('users', data, null);
     return response;
  }
}