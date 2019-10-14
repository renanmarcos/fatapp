import 'package:fatapp/pages/controllers/abstractController.dart';
import 'dart:async';

class ResourceController{
  Future<String> index() async {
    var response = getAllData('resources');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = getData('resources', id);
     return response;
  }

}