import 'package:fatapp/pages/models/event.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'services.dart';
import 'dart:async';

class EventController {
  final _resource = "events";

  Future<List<Event>> getEvents(String token) async {
    final response = await Services().getAllData(_resource, token);
    List<Event> events = Event().fromJsonList(response);
    for (Event event in events) {
      String image = DotEnv().env['FATAPP_API'] + 'files/' + event.banner;
      event.imageUrl = image;
    }
    return events;
  }
}
