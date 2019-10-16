
import 'services.dart';
import 'dart:async';

class SubscriptionController {
  Future<String> index() async {
    var response = Services().getAllData('subscriptions');
    return response;
  }
  Future<String> show(id) async 
  {
     var response = Services().getData('subscriptions', id);
     return response;
  }
  Future<String> update(id, data) async 
  {
     var response = Services().putData('subscriptions', id, data);
     return response;
  }
  Future<String> create(id, data) async 
  {
     var response = Services().postData('subscriptions', data);
     return response;
  }
}