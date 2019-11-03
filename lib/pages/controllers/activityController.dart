import 'package:fatapp/pages/models/acitivity.dart';
import 'services.dart';
import 'dart:async';

class ActivityController {
  final _resource = "activities";

  Future<List<Activity>> index(String token) async {
    final response = await Services().getAllData(_resource, token);
    return Activity().fromJsonList(response);
  }

  Future<Map<String, dynamic>> show(id, token) async {
    return Services().getData(_resource, id, token);
  }

  Future<Map<String, dynamic>> update(id, data, token) async {
    return Services().putData(_resource, id, data, token);
  }

  Future<Map<String, dynamic>> create(id, data, token) async {
    return Services().postData(_resource, data, token);
  }

  Future<Map<String, dynamic>> attendee(id, data, token) async {
    return Services().putData(_resource, id, data, token, '/attendee');
  }
}