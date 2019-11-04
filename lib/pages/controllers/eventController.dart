import 'services.dart';
import 'dart:async';

class EventController {
  final _resource = "events";

  Future<dynamic> index(token) async {
    return Services().getAllData(this._resource, token);
  }

  Future<dynamic> show(id, token) async {
    return Services().getData(this._resource, id, token);
  }

  Future<dynamic> update(id, data, token) async {
    return Services().putData(this._resource, id, data, token);
  }

  Future<dynamic> create(id, data, token) async {
    return Services().postData(this._resource, data, token);
  }
}
