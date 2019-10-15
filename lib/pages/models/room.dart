class Room {
  int id;
  String name;
  int caapacity;
  String type;
  
  Room.fromJson(jsonToParse) {
    json = json.decode(jsonToParse)
    id = json['id'];
    name = json['name'];
  }
}