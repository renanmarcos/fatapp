import 'dart:convert';

class Room {
  int id;
  String name;
  int capacity;
  String type;

  Room({this.id, this.name, this.capacity, this.type});
  
  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    capacity = json['capacity'];
    type = json['type'];
  }
  List<Room> roomList(String body) {
    final list = json.decode(body)
      .map((data) =>Room.fromJson(data))
      .toList();
    return list;
  }
}