import 'dart:convert';

class Audience {
  int id;
  String name;
  String acronym;

  Audience({this.id, this.name, this.acronym});

  Audience.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.acronym = json['acronym'];
  }

  List<Audience> fromJsonList(body) {
    return json.decode(body).map((data) => Audience.fromJson(data)).toList();
  }
}
