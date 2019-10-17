
import 'services.dart';
import 'dart:async';

class EventController {
  Future<String> index() async {
    var response = Services().getAllData('events');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = Services().getData('events', id);
     return response;
  }
  Future<String> update(id, data) async 
  {
     var response = Services().putData('events', id, data);
     return response;
  }
  Future<String> create(id, data) async 
  {
     var response = Services().postData('events', data);
     return response;
  }
}