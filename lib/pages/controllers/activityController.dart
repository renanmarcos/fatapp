
import 'services.dart';
import 'dart:async';

class ActivityController {
  Future<String> index(token) async {
    var response = Services().getAllData('activities', token);
    return response;
  }
  Future<String> show(id, token) async 
  {
     var response = Services().getData('activities', id, token);
     return response;
  }
  Future<String> update(id, data, token) async 
  {
     var response = Services().putData('activities', id, data, token);
     return response;
  }
  Future<String> create(id, data, token) async 
  {
     var response = Services().postData('activities', data, token);
     return response;
  }
}