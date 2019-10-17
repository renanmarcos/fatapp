
import 'services.dart';
import 'dart:async';

class ActivityController {
  Future<String> index() async {
    var response = Services().getAllData('activities');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = Services().getData('activities', id);
     return response;
  }
  Future<String> update(id, data) async 
  {
     var response = Services().putData('activities', id, data);
     return response;
  }
  Future<String> create(id, data) async 
  {
     var response = Services().postData('activities', data);
     return response;
  }
}