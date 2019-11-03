import 'dart:convert';
import 'package:fatapp/pages/models/room.dart';
import 'package:fatapp/pages/models/audience.dart';
import 'package:fatapp/pages/models/speaker.dart';

class Activity {
  int id;
  String title;
  String type;
  String description;
  DateTime initialDate;
  DateTime finalDate;
  Room room;
  Speaker speaker;
  List<Audience> targetAudience;

  Activity({
    this.id, 
    this.title, 
    this.type, 
    this.description, 
    this.initialDate, 
    this.finalDate, 
    this.room, 
    this.speaker, 
    this.targetAudience
  });

  Activity.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.type = json['type'];
    this.description = json['description'];
    this.initialDate = json['initialDate'];
    this.finalDate = json['finalDate'];
    this.room = Room.fromJson(json['room']);
    this.speaker = Speaker.fromJson(json['speaker']); 
    this.targetAudience = Audience().fromJsonList(json['targetAudience']);
  }

  List<Activity> fromJsonList(body) {
    return json.decode(body).map((data) => Activity.fromJson(data)).toList();
  }
}
