import 'dart:convert';

class Event {
  int id;
  String name;
  
 Event({this.id, this.name});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
  List<Event> eventList(String body) {
    final list = json.decode(body)
      .map((data) => Event.fromJson(data))
      .toList();
    return list;
  }
}