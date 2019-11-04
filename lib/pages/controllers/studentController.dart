import 'services.dart';
import 'dart:async';

class StudentController {
  final _resource = "students";

  Future<dynamic> show(id, token) async {
    return Services().getData(this._resource, id, token);
  }

  Future<dynamic> update(id, data, token) async {
    return Services().putData(this._resource, id, data, token);
  }

  Future<dynamic> create(data) async {
    return Services().postData(this._resource, data, null);
  }
}
