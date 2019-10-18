
import 'services.dart';
import 'dart:async';

class SubscriptionController {
  Future<Map<String, dynamic>> index(token) async {
    var response = Services().getAllData('subscriptions', token);
    return response;
  }
  Future<Map<String, dynamic>> show(id, token) async 
  {
     var response = Services().getData('subscriptions', id, token);
     return response;
  }
  Future<Map<String, dynamic>> update(id, data, token) async 
  {
     var response = Services().putData('subscriptions', id, data, token);
     return response;
  }
  Future<Map<String, dynamic>> create(id, data, token) async 
  {
     var response = Services().postData('subscriptions', data, token);
     return response;
  }
}