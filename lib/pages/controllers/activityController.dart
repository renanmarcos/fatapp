import 'package:fatapp/pages/models/acitivity.dart';
import 'package:fatapp/pages/models/event.dart';
import 'services.dart';
import 'dart:async';

class ActivityController {
  final String _resource = "activities";

  Future<List<Activity>> indexFromEvent(Event event, String token) async {
    final response =
        await Services().getAllData("events/${event.id}/" + _resource, token);
    return Activity().fromJsonList(response);
  }

  Future<Map<String, dynamic>> subscribe(
      Activity activity, Object data, String token) async {
    return await Services()
        .putData(_resource, activity.id, data, token, '/subscribe');
  }

  Future<bool> cancelSubscription(
      Activity activity, Object data, String token) async {
    return await Services()
        .putData(_resource, activity.id, data, token, '/unsubscribe');
  }

  Future<Map<String, dynamic>> attendee(id, data, token) async {
    return await Services().putData(_resource, id, data, token, '/attendee');
  }
}
