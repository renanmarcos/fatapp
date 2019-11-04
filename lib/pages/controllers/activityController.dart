import 'package:fatapp/pages/models/acitivity.dart';
import 'package:fatapp/pages/models/event.dart';
import 'services.dart';
import 'dart:async';

class ActivityController {
  final String _resource = "activities";

  Future<List<Activity>> indexFromEvent(Event event, String token) async {
    final response = await Services().getAllData("events/${event.id}/" + _resource, token);
    return Activity().fromJsonList(response);
  }

  Future<Map<String, dynamic>> attendee(id, data, token) async {
    return Services().putData(_resource, id, data, token, '/attendee');
  }
}