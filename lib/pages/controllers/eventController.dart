
import 'services.dart';
import 'dart:async';

class EventController {
  Future<String> index(token) async {
    var response = Services().getAllData('events', token);
    return response;
  }
  Future<String> show(id, token) async 
  {
     var response = Services().getData('events', id, token);
     return response;
  }
  Future<String> update(id, data, token) async 
  {
     var response = Services().putData('events', id, data, token);
     return response;
  }
  Future<String> create(id, data, token) async 
  {
     var response = Services().postData('events', data, token);
     return response;
  }
}