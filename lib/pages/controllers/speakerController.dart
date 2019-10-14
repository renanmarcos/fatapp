import 'package:fatapp/pages/controllers/abstractController.dart';
import 'dart:async';

class SpeakerController{
  Future<String> index() async {
    var response = getAllData('speakers');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = getData('speakers', id);
     return response;
  }
}