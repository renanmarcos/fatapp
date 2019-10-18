
import 'services.dart';
import 'dart:async';

class ResourceController {
  Future<Map<String, dynamic>> index(token) async {
    var response = Services().getAllData('resources', token);
    return response;
  }
  Future<Map<String, dynamic>> show(id, token) async 
  {
     var response = Services().getData('resources', id, token);
     return response;
  }
  Future<Map<String, dynamic>> update(id, data, token) async 
  {
     var response = Services().putData('resources', id, data, token);
     return response;
  }
  Future<Map<String, dynamic>> create(id, data, token) async 
  {
     var response = Services().postData('resources', data, token);
     return response;
  }
}