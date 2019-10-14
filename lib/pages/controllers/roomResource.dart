import 'package:fatapp/pages/controllers/abstractController.dart';
import 'dart:async';

class RoomResourceController{
  Future<String> index() async {
    var response = getAllData('roomResources');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = getData('roomResources', id);
     return response;
  }
}