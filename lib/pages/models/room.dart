import 'dart:convert';

class Room {
  int id;
  String name;
  int capacity;
  String type;

  Room({this.id, this.name, this.capacity, this.type});

  Room.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.capacity = json['capacity'];
    this.type = json['type'];
  }

  List<Room> roomList(String body) {
    return json.decode(body).map((data) => Room.fromJson(data)).toList();
  }
}
