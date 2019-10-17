
import 'services.dart';
import 'dart:async';

class SpeakerController {
  Future<String> index(token) async {
    var response = Services().getAllData('speakers', token);
    return response;
  }
  Future<String> show(id, token) async 
  {
     var response = Services().getData('speakers', id, token);
     return response;
  }
  Future<String> update(id, data, token) async 
  {
     var response = Services().putData('speakers', id, data, token);
     return response;
  }
  Future<String> create(id, data, token) async 
  {
     var response = Services().postData('speakers', data, token);
     return response;
  }
}