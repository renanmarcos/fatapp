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

  List<Audience> fromJsonList(List json) {
    return json.map((data) => Audience.fromJson(data)).toList();
  }
}
