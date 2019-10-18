
import 'services.dart';
import 'dart:async';

class EventController {
  Future<Map<String, dynamic>>index(token) async {
    var response = Services().getAllData('events', token);
    return response;
  }
  Future<Map<String, dynamic>> show(id, token) async 
  {
     var response = Services().getData('events', id, token);
     return response;
  }
  Future<Map<String, dynamic>> update(id, data, token) async 
  {
     var response = Services().putData('events', id, data, token);
     return response;
  }
  Future<Map<String, dynamic>> create(id, data, token) async 
  {
     var response = Services().postData('events', data, token);
     return response;
  }
}