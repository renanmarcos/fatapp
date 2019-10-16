import 'dart:convert';

class Activity {
  int id;
  String title;
  DateTime startAt;
  String speaker;
  String description;
  
  Activity({this.id, this.title, this.startAt, this.speaker, this.description});

  Activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    startAt = json['start_at'];
    speaker = json['speaker'];
    description = json['description'];
  }
  List<Activity> userList(String body) {
    final list = json.decode(body).cast<Map<String, dynamic>>();
    return list.map<Activity>((json) => Activity.fromJson(json)).toList();
  }
}