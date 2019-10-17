
import 'services.dart';
import 'dart:async';

class RoomController {
  Future<String> index(token) async {
    var response = Services().getAllData('rooms', token);
    return response;
  }
  Future<String> show(id, token) async 
  {
     var response = Services().getData('rooms', id, token);
     return response;
  }
  Future<String> update(id, data, token) async 
  {
     var response = Services().putData('rooms', id, data, token);
     return response;
  }
  Future<String> create(id, data, token) async 
  {
     var response = Services().postData('rooms', data, token);
     return response;
  }
}