
import 'services.dart';
import 'dart:async';

class ActivityController {
  Future<Map<String, dynamic>> index(token) async {
    var response = Services().getAllData('activities', token);
    return response;
  }
  Future<Map<String, dynamic>> show(id, token) async 
  {
     var response = Services().getData('activities', id, token);
     return response;
  }
  Future<Map<String, dynamic>> update(id, data, token) async 
  {
     var response = Services().putData('activities', id, data, token);
     return response;
  }
  Future<Map<String, dynamic>> create(id, data, token) async 
  {
     var response = Services().postData('activities', data, token);
     return response;
  }

  Future<Map<String, dynamic>> attendee(id, data, token) async 
  {
 
     var response = Services().putDataAttendee( id, data, token);
     
     return response;
  }
}