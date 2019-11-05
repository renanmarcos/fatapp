import 'package:fatapp/pages/models/event.dart';

import 'services.dart';
import 'dart:async';

class EventController {
  final _resource = "events";

  Future<List<Event>> getEvents(String token) async {
    final response = await Services().getAllData(_resource, token);
    return Event().fromJsonList(response);
  }
}
