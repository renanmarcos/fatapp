class Event {
  int id;
  String name;
  
  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}