import 'services.dart';
import 'dart:async';

class SubscriptionController {
  final _resource = "subscriptions";

  Future<Map<String, dynamic>> index(token) async {
    return Services().getAllData(this._resource, token);
  }

  Future<Map<String, dynamic>> show(id, token) async {
    return Services().getData(this._resource, id, token);
  }

  Future<Map<String, dynamic>> update(id, data, token) async {
    return Services().putData(this._resource, id, data, token);
  }

  Future<Map<String, dynamic>> create(id, data, token) async {
    return Services().postData(this._resource, data, token);
  }
}
