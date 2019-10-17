
import 'services.dart';
import 'dart:async';

class ResourceController {
  Future<String> index(token) async {
    var response = Services().getAllData('resources', token);
    return response;
  }
  Future<String> show(id, token) async 
  {
     var response = Services().getData('resources', id, token);
     return response;
  }
  Future<String> update(id, data, token) async 
  {
     var response = Services().putData('resources', id, data, token);
     return response;
  }
  Future<String> create(id, data, token) async 
  {
     var response = Services().postData('resources', data, token);
     return response;
  }
}