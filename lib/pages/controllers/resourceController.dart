
import 'services.dart';
import 'dart:async';

class ResourceController {
  Future<String> index() async {
    var response = Services().getAllData('resources');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = Services().getData('resources', id);
     return response;
  }
  Future<String> update(id, data) async 
  {
     var response = Services().putData('resources', id, data);
     return response;
  }
  Future<String> create(id, data) async 
  {
     var response = Services().postData('resources', data);
     return response;
  }
}