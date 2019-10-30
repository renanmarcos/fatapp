import 'dart:convert';

class Event {
  int id;
  String name;

  Event({this.id, this.name});

  Event.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
  }

  List<Event> eventList(String body) {
    return json.decode(body).map((data) => Event.fromJson(data)).toList();
  }
}
