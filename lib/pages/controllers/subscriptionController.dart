
import 'services.dart';
import 'dart:async';

class SubscriptionController {
  Future<String> index(token) async {
    var response = Services().getAllData('subscriptions', token);
    return response;
  }
  Future<String> show(id, token) async 
  {
     var response = Services().getData('subscriptions', id, token);
     return response;
  }
  Future<String> update(id, data, token) async 
  {
     var response = Services().putData('subscriptions', id, data, token);
     return response;
  }
  Future<String> create(id, data, token) async 
  {
     var response = Services().postData('subscriptions', data, token);
     return response;
  }
}