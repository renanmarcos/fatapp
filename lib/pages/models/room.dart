class Room {
  int id;
  String name;
  int caapacity;
  String type;
  
  Room.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}