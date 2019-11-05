class Event {
  int id;
  String title;
  String edition;
  DateTime initialDate;
  DateTime finalDate;
  String banner;
  String imageUrl;
  String description;

  Event({this.id, this.title, this.edition, this.initialDate, this.finalDate, this.banner, this.description, this.imageUrl});

  Event.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.title = json['title'];
    this.edition = json['edition'];
    this.initialDate = DateTime.parse(json['initialDate']);
    this.finalDate = DateTime.parse(json['finalDate']);
    this.banner = json['banner'];
    this.description = json['description'];
  }
  List<Event> fromJsonList(List json) {
    return json.map((data) => Event.fromJson(data)).toList();
  }
}
