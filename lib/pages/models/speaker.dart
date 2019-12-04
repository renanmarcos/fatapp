import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Speaker {
  int id;
  String name;
  String curriculum;
  String pictureUrl;

  Speaker.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['speakerName'];
    this.curriculum = json['speakerCurriculum'];
    this.pictureUrl = json['speakerPicture'] != null
        ? DotEnv().env['FATAPP_API'] + 'files/' + json['speakerPicture']
        : null;
  }

  List<Speaker> fromJsonList(body) {
    return json.decode(body).map((data) => Speaker.fromJson(data)).toList();
  }
}
