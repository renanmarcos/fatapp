import 'dart:convert';

class Activity {
  int id;
  String title;
  DateTime startAt;
  String speaker;
  String description;

  Activity({this.id, this.title, this.startAt, this.speaker, this.description});

  Activity.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.startAt = json['start_at'];
    this.speaker = json['speaker'];
    this.description = json['description'];
  }

  List<Activity> activityList(String body) {
    return json.decode(body).map((data) => Activity.fromJson(data)).toList();
  }
}
