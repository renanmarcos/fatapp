import 'package:fatapp/pages/controllers/abstractController.dart';
import 'dart:async';

class EventController{
  Future<String> index() async {
    var response = getAllData('events');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = getData('events', id);
     return response;
  }
}