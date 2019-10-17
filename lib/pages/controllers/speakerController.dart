
import 'services.dart';
import 'dart:async';

class SpeakerController {
  Future<String> index() async {
    var response = Services().getAllData('speakers');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = Services().getData('speakers', id);
     return response;
  }
  Future<String> update(id, data) async 
  {
     var response = Services().putData('speakers', id, data);
     return response;
  }
  Future<String> create(id, data) async 
  {
     var response = Services().postData('speakers', data);
     return response;
  }
}