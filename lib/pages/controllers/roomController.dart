
import 'services.dart';
import 'dart:async';

class RoomController {
  Future<String> index() async {
    var response = Services().getAllData('rooms');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = Services().getData('rooms', id);
     return response;
  }
  Future<String> update(id, data) async 
  {
     var response = Services().putData('rooms', id, data);
     return response;
  }
  Future<String> create(id, data) async 
  {
     var response = Services().postData('rooms', data);
     return response;
  }
}