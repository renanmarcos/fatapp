
import 'services.dart';
import 'dart:async';

class RoomController {
  Future<Map<String, dynamic>> index(token) async {
    var response = Services().getAllData('rooms', token);
    return response;
  }
  Future<Map<String, dynamic>> show(id, token) async 
  {
     var response = Services().getData('rooms', id, token);
     return response;
  }
  Future<Map<String, dynamic>> update(id, data, token) async 
  {
     var response = Services().putData('rooms', id, data, token);
     return response;
  }
  Future<Map<String, dynamic>> create(id, data, token) async 
  {
     var response = Services().postData('rooms', data, token);
     return response;
  }
}