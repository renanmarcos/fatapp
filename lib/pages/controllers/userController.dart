import 'services.dart';
import 'dart:async';

class UserController {
  final _resource = "users";

  Future<dynamic> show(id, token) async {
    return Services().getData(this._resource, id, token);
  }

  Future<dynamic> update(id, data, token) async {
    return Services().putData(this._resource, id, data, token);
  }

  Future<dynamic> create(data) async {
    return Services().postData(this._resource, data, null);
  }
  
  Future<dynamic> changePassword(data, token) async {
     return Services().postData('auth/change-password', data, token);
  }

  Future<dynamic> login(data) async {
    return Services().postData('auth/token', data, null);
  }
}
