class Event {
  int id;
  String name;
  
  Event.fromJson(jsonToParse) {
    json = json.decode(jsonToParse)
    id = json['id'];
    name = json['name'];
  }
}