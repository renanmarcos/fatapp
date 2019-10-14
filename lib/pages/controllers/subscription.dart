import 'package:fatapp/pages/controllers/abstractController.dart';
import 'dart:async';

class SubscriptionController{
  Future<String> index() async {
    var response = getAllData('subscriptions');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = getData('subscriptions', id);
     return response;
  }
  Future<String> update(id, data) async 
  {
     var response = putData('subscriptions', id, data);
     return response;
  }
  Future<String> create(id, data) async 
  {
     var response = postData('subscriptions', data);
     return response;
  }
}