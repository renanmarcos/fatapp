
import 'services.dart';
import 'dart:async';

class UserController {
  Future<Map<String, dynamic>> show(id, token) async 
  {
     final response = Services().getData('users', id, token);
     return response;
  }
  Future<Map<String, dynamic>> update(id, data, token) async 
  {
     final response = Services().putData('users', id, data, token);
     return response;
  }
  Future<Map<String, dynamic>> login(data) async 
  {
     final response = Services().postData('auth/token', data, null);
     return response;
  }
  Future<Map<String, dynamic>> create(data) async 
  {
     final response = Services().postData('users', data, null);
     return response;
  }
}