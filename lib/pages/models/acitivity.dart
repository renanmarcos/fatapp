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

  Activity(
      {this.id,
      this.title,
      this.type,
      this.description,
      this.initialDate,
      this.finalDate,
      this.room,
      this.speaker,
      this.targetAudience});

  Activity.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.type = json['type'];
    this.description = json['description'];
    this.initialDate = DateTime.parse(json['initialDate']);
    this.finalDate = DateTime.parse(json['finalDate']);
    this.room = json['room'] != null ? Room.fromJson(json['room']) : null;
    this.speaker =
        json['speaker'] != null ? Speaker.fromJson(json['speaker']) : null;
    this.targetAudience = json['targetAudience'] != null
        ? Audience().fromJsonList(json['targetAudience'])
        : null;
  }

  List<Activity> fromJsonList(List json) {
    return json.map((data) => Activity.fromJson(data)).toList();
  }
}
