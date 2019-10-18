
import 'services.dart';
import 'dart:async';

class SpeakerController {
  Future<Map<String, dynamic>> index(token) async {
    var response = Services().getAllData('speakers', token);
    return response;
  }
  Future<Map<String, dynamic>> show(id, token) async 
  {
     var response = Services().getData('speakers', id, token);
     return response;
  }
  Future<Map<String, dynamic>> update(id, data, token) async 
  {
     var response = Services().putData('speakers', id, data, token);
     return response;
  }
  Future<Map<String, dynamic>> create(id, data, token) async 
  {
     var response = Services().postData('speakers', data, token);
     return response;
  }
}