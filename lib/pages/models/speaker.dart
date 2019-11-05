import 'dart:convert';

class Speaker {
  int id;
  String name;
  String curriculum;
  String pictureUrl;

  Speaker.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['speakerName'];
    this.curriculum = json['speakerCurriculum'];
    this.pictureUrl = json['speakerPicture'];
  }

  List<Speaker> fromJsonList(body) {
    return json.decode(body).map((data) => Speaker.fromJson(data)).toList();
  }
}
