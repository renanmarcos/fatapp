import 'package:fatapp/pages/controllers/abstractController.dart';
import 'dart:async';

class ActivityController{
  Future<String> index() async {
    var response = getAllData('activities');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = getData('activities', id);
     return response;
  }
}