import 'package:fatapp/pages/controllers/abstractController.dart';
import 'dart:async';

class RoomController{
  Future<String> index() async {
    var response = getAllData('rooms');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = getData('rooms', id);
     return response;
  }
}